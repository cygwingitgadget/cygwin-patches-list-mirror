Return-Path: <cygwin-patches-return-7548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23772 invoked by alias); 14 Nov 2011 11:41:32 -0000
Received: (qmail 23746 invoked by uid 22791); 14 Nov 2011 11:41:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 14 Nov 2011 11:40:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D80A2C0486; Mon, 14 Nov 2011 12:40:47 +0100 (CET)
Date: Mon, 14 Nov 2011 11:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Newlib's implementation of isalnum() is causing compiler warnings
Message-ID: <20111114114047.GH15154@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CALqHt2A7o1oDwxooQwAskeviUqFYGbb3KKCPeczSkvppy1wOsw@mail.gmail.com> <CALqHt2BecaAQ6VrRFLEPgZSOu8C+E8qgAmG1SXDYVonkfwGyWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALqHt2BecaAQ6VrRFLEPgZSOu8C+E8qgAmG1SXDYVonkfwGyWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00038.txt.bz2

On Nov 14 11:16, Rafal Zwierz wrote:
> Hi,
> 
> First of all apologies if it is not the right place to submit patches
> for newlib/libc used by cygwin. If it's not then I would appreciate if
> you could point me to the right place for submitting such patches.

The right place for newlib patches is the newlib mailing list
newlib AT sourceware DOT org.  However...

> If it is the right place then please read on.
> 
> main.c (attached) is a simple app which, when compiled with under Cygwin
> 
> gcc -Wall -Werror main.c
> 
> shows the following problem:
> 
> cc1: warnings being treated as errors
> main.c: In function âmainâ:
> main.c:6:4: error: array subscript has type âcharâ
> 
> The fix is quite simple and is contained in patch.txt.

...this is not the right thing to do.  Actually the problem is in your
application.  The ctype warnings in newlib have been added exactly for
the benefit of application developers to warn them about using the ctype
macros in an incorrect way.

See the POSIX man page of isalpha (but this is valid for all isFOO ctype
macros):
http://pubs.opengroup.org/onlinepubs/9699919799/functions/isalpha.html

Note especially:

  The c argument is an int, the value of which the application shall
  ensure is a character representable as an unsigned char or equal to
                                            ^^^^^^^^^^^^^
  the value of the macro EOF. If the argument has any other value, the
  behavior is undefined.

It's a common mistake in applications to use a signed char value as
argument to the ctype macros.  While this was no problem way back when
everything was basically ASCII-only, it's a problem if you take other
codesets into account.  Here's why:

The common definition of EOF is:

  #define EOF (-1)

Now consider this code:

  setlocale (LC_ALL, "en_US.iso88591");
  char s[2] = { 0xff, 0 };  // 0xff is the character 'Ã¿' in ISO-8859-1,
                            // aka LATIN SMALL LETTER Y WITH DIAERESIS
  if (isalpha (s[0]))
    printf ("isalpha is true\n");

The text will not be printed, because c is sign extended to int, thus
((char) 0xff) will become -1 in the call to isalpha.  Since -1 is EOF,
the character 'Ã¿' will be handled incorrectly.

The right thing to do is to call

  if (isalpha ((unsigned char) c))

or, to create portable, multibyte-aware code:

  wchar_t wc;
  mbtowc (&wc, s, strlen (s));
  if (iswalpha ((wint_t) wc))


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
