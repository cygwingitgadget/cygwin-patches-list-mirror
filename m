From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to dir.cc
Date: Thu, 19 Jul 2001 16:31:00 -0000
Message-id: <20010719193041.C7237@redhat.com>
References: <911C684A29ACD311921800508B7293BA010A8A57@cnmail>
X-SW-Source: 2001-q3/msg00027.html

This patch looks good to me but I'm not in a position to test it much.

Corinna, how does it look to you?

cgf

On Thu, Jul 19, 2001 at 05:27:30PM -0400, Mark Bradshaw wrote:
>I've track down a problem with the sftp server hanging under Windows NT (not
>Windows 2000) to the readdir function in dir.cc.  The sftp server called
>readdir with a directory handle repeatedly to get all the directory entries.
>When the directory has been fully read it calls readdir one more time with a
>(now) invalid handle.  This causes FindNextFileA to never return.  I've add
>a small bit of code to check for the invalid handle before called
>FindNextFileA, and that seems to have corrected the problem.  The latest cvs
>version of dir.cc didn't show any changes to readdir, so I assume this
>hasn't been patched yet.
>
>There is code that checks for an invalid handle, but it also checks whether
>it's the first time readdir has been called.  This doesn't match the error
>condition occurring with the sftp server.  I added a quick check after that
>that simply returns res as NULL.  There may be additional things that you
>want to add in.
>
>As I noted above, this error only occurs with Windows NT, not 2000, but the
>changed code still appears to function normally under Windows 2000.
>
>BTW, any idea when the next version of the cygwin dll will be released?
>
>Mark
>
>
>----------------------------------------------------------------------------
>----
>
>--- /usr/src/cygwin-1.3.2-1/winsup/cygwin/dir.cc        Sat May 12 18:32:40
>2001
>+++ /tmp/dir.cc Thu Jul 19 14:46:13 2001
>@@ -160,6 +160,10 @@ readdir (DIR * dir)
>          return res;
>        }
>     }
>+  else if (dir->__d_u.__d_data.__handle == INVALID_HANDLE_VALUE)
>+    {
>+      return res;
>+    }
>   else if (!FindNextFileA (dir->__d_u.__d_data.__handle, &buf))
>     {
>       DWORD lasterr = GetLastError ();
>

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
