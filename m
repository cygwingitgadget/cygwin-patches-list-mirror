Return-Path: <cygwin-patches-return-6036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7818 invoked by alias); 9 Mar 2007 07:58:10 -0000
Received: (qmail 7807 invoked by uid 22791); 9 Mar 2007 07:58:09 -0000
X-Spam-Check-By: sourceware.org
Received: from SMT02001.global-sp.net (HELO SMT02001.global-sp.net) (193.168.50.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 09 Mar 2007 07:58:04 +0000
Received: from [192.168.100.1] (mna75-8-82-234-66-240.fbx.proxad.net [82.234.66.240]) 	by SMT02001.global-sp.net (Postfix) with ESMTP id 6051E376809 	for <cygwin-patches@cygwin.com>; Fri,  9 Mar 2007 08:57:51 +0100 (CET)
Date: Fri, 09 Mar 2007 07:58:00 -0000
From: Christophe GRENIER <grenier@cgsecurity.org>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in pread/pwrite ?
In-Reply-To: <20070308234449.GA7745@trixie.casa.cgf.cx>
Message-ID: <Pine.LNX.4.64.0703090833210.4757@adsl.cgsecurity.org>
References: <Pine.LNX.4.64.0703082349050.17686@adsl.cgsecurity.org>  <20070308234449.GA7745@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck:
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00017.txt.bz2

On Thu, 8 Mar 2007, Christopher Faylor wrote:

> The pread() that Cygwin does uses is in fhandler_disk_file.cc.

Thanks, now i know where the culprit is and understand why
I had a problem with my proposed patch ;-)

> All of that aside, I don't see how ignoring an lseek() failure
> could be considered to be a good thing.

I have done more research since, have a look to this glibc
pread implementation:

ssize_t
__libc_pread (int fd, void *buf, size_t nbyte, off_t offset)
{
   /* Since we must not change the file pointer preserve the value so that
      we can restore it later.  */
   int save_errno;
   ssize_t result;
   off_t old_offset = __libc_lseek (fd, 0, SEEK_CUR);
   if (old_offset == (off_t) -1)
     return -1;

   /* Set to wanted position.  */
   if (__libc_lseek (fd, offset, SEEK_SET) == (off_t) -1)
     return -1;

   /* Write out the data.  */
   result = __libc_read (fd, buf, nbyte);

   /* Now we have to restore the position.  If this fails we have to
      return this as an error.  But if the writing also failed we
      return this error.  */
   save_errno = errno;
   if (__libc_lseek (fd, old_offset, SEEK_SET) == (off_t) -1)
     {
       if (result == -1)
         __set_errno (save_errno);
       return -1;
     }
   __set_errno (save_errno);

   return result;
}

For the full file:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/posix/pread.c?rev=1.6&content-type=text/x-cvsweb-markup&cvsroot=glibc

glibc implementation seems correct in ignoring lseek
failure if read has been successfull.

Regards,
 	Christophe

-- 
    ,-~~-.___.     ._.
   / |  '     \    | |"""""""""|   Christophe GRENIER
  (  )         0   | |         | grenier@cgsecurity.org
   \_/-, ,----'    | |         |
      ====         !_!--v---v--"
      /  \-'~;      |""""""""|   TestDisk & PhotoRec
     /  __/~| ._-""||        |   Data Recovery
   =(  _____|_|____||________|   http://www.cgsecurity.org
