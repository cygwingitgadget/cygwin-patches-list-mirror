Return-Path: <cygwin-patches-return-6189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23719 invoked by alias); 12 Dec 2007 17:59:28 -0000
Received: (qmail 23708 invoked by uid 22791); 12 Dec 2007 17:59:27 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.185)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 17:59:17 +0000
Received: by rv-out-0910.google.com with SMTP id b22so266629rvf.38         for <cygwin-patches@cygwin.com>; Wed, 12 Dec 2007 09:59:15 -0800 (PST)
Received: by 10.141.136.19 with SMTP id o19mr516540rvn.250.1197482355639;         Wed, 12 Dec 2007 09:59:15 -0800 (PST)
Received: by 10.140.188.9 with HTTP; Wed, 12 Dec 2007 09:59:15 -0800 (PST)
Message-ID: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com>
Date: Wed, 12 Dec 2007 17:59:00 -0000
From: "Craig MacGregor" <cmacgreg@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [patch] poll() return value is actually that of select()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00041.txt.bz2

bug example src: http://pastebin.com/f719e4c11

First off... I've been happily using Cygwin for years, glad I finally
have a patch to contribute...Thanks!

While testing some socket code on Cygwin and Linux, I noticed the
returns from poll() were always twice what they were on Linux when a
socket had been closed remotely and then polled().

From  'man 2 poll' on debian:

"On success, a positive number is returned; this is the number of
structures which have non-zero revents fields (in other words, those
descriptors  with  events  or errors  reported).   A  value  of 0
indicates that the call timed out and no file descriptors were ready.
On error, -1 is returned, and errno is set appropriately."

Digging deeper, I found that Cygwin's poll() is implemented with
cygwin_select(), and thus returns the total number of ISSET events,
instead of just the number of fds with events. Thus, the behavior is:

 "On  success,  select()  and  pselect() return the number of file
descriptors contained in the three returned descriptor sets (that is,
the total number  of  bits that  are  set  in readfds, writefds,
exceptfds) which may be zero if the timeout expires before anything
interesting happens.  On error, -1 is returned, and errno is  set
appropriately;  the sets and timeout become undefined, so do not rely
on their contents after an error."

Attached is some goo which makes poll() work as expected.... compiled,
tested, works... fyi, as of 9:30am EST string.h broke the build, i had
to roll it back.

-craig

--------
2007-12-12  Craig MacGregor  <cmacgreg@gmail.com>

	* poll.cc (poll): Return count of fds with events instead of total event count

Index: cygwin/poll.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/poll.cc,v
retrieving revision 1.48
diff -u -p -r1.48 poll.cc
--- cygwin/poll.cc      31 Jul 2006 14:27:56 -0000      1.48
+++ cygwin/poll.cc      12 Dec 2007 13:29:53 -0000
@@ -76,15 +76,18 @@ poll (struct pollfd *fds, nfds_t nfds, i
   if (invalid_fds)
     return invalid_fds;

-  int ret = cygwin_select (max_fd + 1, read_fds, write_fds,
except_fds, timeout < 0 ? NULL : &tv);
+  int ret = cygwin_select (max_fd + 1, read_fds, write_fds,
except_fds, timeout < 0 ? NULL : &tv);
+
+  int ir = 0, ret_p = 0;
+    /* Count fds in ISSETs for return, but just once each */

   if (ret > 0)
-    for (unsigned int i = 0; i < nfds; ++i)
+    for (unsigned int i = 0; i < nfds; ret_p+=ir, ir = 0, ++i)
       {
        if (fds[i].fd >= 0)
          {
            if (cygheap->fdtab.not_open (fds[i].fd))
-             fds[i].revents = POLLHUP;
+             ir = 1, fds[i].revents = POLLHUP;
            else
              {
                fhandler_socket *sock;
@@ -98,22 +101,23 @@ poll (struct pollfd *fds, nfds_t nfds, i
                     will return -1 with errno set to the appropriate value."
                     So it looks like there's actually no good reason to
                     return POLLERR. */
-                 fds[i].revents |= POLLIN;
+                 ir = 1, fds[i].revents |= POLLIN;
                /* Handle failed connect. */
                if (FD_ISSET(fds[i].fd, write_fds)
                    && (sock = cygheap->fdtab[fds[i].fd]->is_socket ())
                    && sock->connect_state () == connect_failed)
-                 fds[i].revents |= (POLLIN | POLLERR);
+                 ir = 1, fds[i].revents |= (POLLIN | POLLERR);
                else
                  {
                    if (FD_ISSET(fds[i].fd, write_fds))
-                     fds[i].revents |= POLLOUT;
+                     ir = 1, fds[i].revents |= POLLOUT;
                    if (FD_ISSET(fds[i].fd, except_fds))
-                     fds[i].revents |= POLLPRI;
+                     ir = 1, fds[i].revents |= POLLPRI;
                  }
              }
-         }
+         }
+
       }

-  return ret;
+  return !ret_p ? ret : ret_p;
 }
