Return-Path: <cygwin-patches-return-4476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5871 invoked by alias); 5 Dec 2003 11:14:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5862 invoked from network); 5 Dec 2003 11:14:47 -0000
Date: Fri, 05 Dec 2003 11:14:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031205111443.GB2456@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00195.txt.bz2

Two questions:

On Dec  4 22:16, Pierre A. Humblet wrote:
> +locked_append (int fd, const void * buf, size_t size)
> +{
> +  struct __flock64 lock_buffer = {F_WRLCK, SEEK_SET, 0, 0, 0};
> +  int count = 0;
> +
> +  do
> +    if ((lock_buffer.l_start = lseek64 (fd, 0, SEEK_END)) != (_off64_t)-1
> +	&& fcntl_worker (fd, F_SETLK, &lock_buffer) != -1)

What is the advantage of using lseek(SEEK_END) and using that value
for fcntl(F_SETLK, SEEK_SET) over just using fcntl(F_SETLK, SEEK_END)?
Especially since lseek(SEEK_END) is then called afterwards anyway.

> +      {
> +	if (lseek64 (fd, 0, SEEK_END) != (_off64_t)-1)
> +	  write (fd, buf, size);
> +	lock_buffer.l_type = F_UNLCK;
> +	fcntl_worker (fd, F_SETLK, &lock_buffer);
> +	break;
> +      }
> +  while (count++ < 4
> +	 && (errno == EACCES || errno == EAGAIN)
> +	 && !usleep (1000));

What is the advantage of using a finite loop with fcntl(F_SETLK) over
using fcntl(F_SETLKW) just once?  This seems potentially less secure
than F_SETLKW and also less secure than the former Mutex solution.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
