Return-Path: <cygwin-patches-return-6037-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 903 invoked by alias); 9 Mar 2007 08:46:37 -0000
Received: (qmail 892 invoked by uid 22791); 9 Mar 2007 08:46:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 09 Mar 2007 08:46:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0401D6D42F9; Fri,  9 Mar 2007 09:46:28 +0100 (CET)
Date: Fri, 09 Mar 2007 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in pread/pwrite ?
Message-ID: <20070309084627.GA508@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.64.0703082349050.17686@adsl.cgsecurity.org> <20070308234449.GA7745@trixie.casa.cgf.cx> <Pine.LNX.4.64.0703090833210.4757@adsl.cgsecurity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703090833210.4757@adsl.cgsecurity.org>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00018.txt.bz2

On Mar  9 08:57, Christophe GRENIER wrote:
> On Thu, 8 Mar 2007, Christopher Faylor wrote:
> >All of that aside, I don't see how ignoring an lseek() failure
> >could be considered to be a good thing.
> 
> I have done more research since, have a look to this glibc
> pread implementation:
> 
> ssize_t
> __libc_pread (int fd, void *buf, size_t nbyte, off_t offset)
> {
>   /* Since we must not change the file pointer preserve the value so that
>      we can restore it later.  */
>   int save_errno;
>   ssize_t result;
>   off_t old_offset = __libc_lseek (fd, 0, SEEK_CUR);
>   if (old_offset == (off_t) -1)
>     return -1;
    ^^^^^^^^^^^^

>   /* Set to wanted position.  */
>   if (__libc_lseek (fd, offset, SEEK_SET) == (off_t) -1)
>     return -1;
    ^^^^^^^^^^^^

>   /* Write out the data.  */
>   result = __libc_read (fd, buf, nbyte);
> 
>   /* Now we have to restore the position.  If this fails we have to
>      return this as an error.  But if the writing also failed we
>      return this error.  */
>   save_errno = errno;
>   if (__libc_lseek (fd, old_offset, SEEK_SET) == (off_t) -1)
>     {
>       if (result == -1)
>         __set_errno (save_errno);
>       return -1;
        ^^^^^^^^^^

>     }
>   __set_errno (save_errno);
> 
>   return result;
> }
> 
> glibc implementation seems correct in ignoring lseek
> failure if read has been successfull.

This code does not at one point ignore the return code of lseek.
What it does is, it uses the return code of read if the read failed,
but a failing lseek always leads to pread returning -1.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
