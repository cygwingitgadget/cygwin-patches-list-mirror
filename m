Return-Path: <cygwin-patches-return-1497-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 5500 invoked by alias); 15 Nov 2001 11:53:53 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 5460 invoked from network); 15 Nov 2001 11:53:51 -0000
Message-ID: <3BF3ACC6.C994956A@syntrex.com>
Date: Thu, 11 Oct 2001 12:08:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: [PATHC] Re: 1.3.5: write(2) system call fails with 0 length
References: <5.1.0.14.2.20011113215143.03327810@pop.mssinternet.com> <20011114.135353.111406103.gotoh@taiyo.co.jp> <3BF24170.71D1CADF@syntrex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00029.txt.bz2

There was no feedback on this so I post again :) Is this
cygwin behaviour the expected behaviour ?

Pavel Tsekov wrote:
> 
> Shun-ichi GOTO wrote:
> >
> > >>>>> at Tue, 13 Nov 2001 21:58:32 -0600
> > >>>>> Randy Reitz <rreitz@mssinternet.com> said,>
> >
> > > Here is a test program....
> >
> > It's strange test.
> > Do like this, and get result: "2nd write() failed: Bad address".
> > So you should give valid pointer as 2nd argument of 2nd write() call.
> > for example, write (fd, buf, 0);
> >
> 
> It's not so strange if you think about it :) If a length of 0 is given
> there is no reason to check the pointer for being valid IMO.
> 
> However here is what the linux man page says about write - havent
> checked
> any other source which may be more confident though:
> 
> RETURN VALUE
>        On  success,  the  number of bytes written are returned (zero
> indicates nothing was written).
>        On error, -1 is returned, and errno is set appropriately.  If
> count is zero and the file
>        descriptor refers to a regular file, 0 will  be  returned without
> causing any other effect.
>        For a special file, the results are not portable.
> 
> So at least linux just checks for valid fd when the len is 0.
> 
> And the testcase which Randy posted is just fine when run on Linux of
> course
> if the file exists.
> 
> [ptsekov@enigma Src]$ ~/Src/write_test
> ret=0, errno=0
> 
> If the file does not exists at the time the testcase is run i get:
> 
> [ptsekov@enigma Src]$ ~/Src/write_test
> ret=-1, errno=9 (Bad file descriptor)
> 
> Attached is a simple patch which moves the buffer check after the
> check for valid file descriptor and the check for zero len.
> 
> 2001-11-14  Pavel Tsekov  <ptsekov@syntrex.com>
> 
> * syscalls.cc (_write): Check if the third argument of _write() is zero.
> If the first argument of _write() is a valid file descriptor and the
> third
> argument is zero - return 0 without doing anything else.
> Perform a validation check on the second argument of _write() only if
> the
> _write() is requested on a valid file descriptor and the length of the
> buffer being written is not zero.
> 
>   ------------------------------------------------------------------------
> --- syscalls.cc.ORIG    Wed Nov 14 10:33:03 2001
> +++ syscalls.cc Wed Nov 14 10:36:41 2001
> @@ -355,15 +355,21 @@ _read (int fd, void *ptr, size_t len)
>  extern "C" ssize_t
>  _write (int fd, const void *ptr, size_t len)
>  {
> -  if (__check_invalid_read_ptr_errno (ptr, len))
> -    return -1;
> -
>    int res = -1;
> 
>    sigframe thisframe (mainthread);
>    cygheap_fdget cfd (fd);
>    if (cfd < 0)
>      goto done;
> +
> +  if (len == 0)
> +    {
> +      res = 0;
> +      goto done;
> +    }
> +
> +  if (__check_invalid_read_ptr_errno (ptr, len))
> +    return -1;
> 
>    /* Could block, so let user know we at least got here.  */
>    if (fd == 1 || fd == 2)
> 
>   ------------------------------------------------------------------------
> --
> Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> Bug reporting:         http://cygwin.com/bugs.html
> Documentation:         http://cygwin.com/docs.html
> FAQ:                   http://cygwin.com/faq/
