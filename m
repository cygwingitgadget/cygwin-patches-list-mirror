Return-Path: <cygwin-patches-return-7761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11232 invoked by alias); 24 Oct 2012 16:02:28 -0000
Received: (qmail 11221 invoked by uid 22791); 24 Oct 2012 16:02:27 -0000
X-SWARE-Spam-Status: No, hits=-4.3 required=5.0	tests=AWL,BAYES_00,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_CG
X-Spam-Check-By: sourceware.org
Received: from mail-wg0-f45.google.com (HELO mail-wg0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 16:02:21 +0000
Received: by mail-wg0-f45.google.com with SMTP id dq12so429238wgb.2        for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 09:02:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.135.85 with SMTP id t63mr9581578wei.93.1351094540459; Wed, 24 Oct 2012 09:02:20 -0700 (PDT)
Received: by 10.216.24.147 with HTTP; Wed, 24 Oct 2012 09:02:20 -0700 (PDT)
In-Reply-To: <20121024154231.GA4261@ednor.casa.cgf.cx>
References: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com>	<50880443.2020701@cs.utoronto.ca>	<20121024154231.GA4261@ednor.casa.cgf.cx>
Date: Wed, 24 Oct 2012 16:02:00 -0000
Message-ID: <CAEwic4Y+QovZOtTTwD9NG9ZB5zYx6pvraQcknu_jpPNMWukU4w@mail.gmail.com>
Subject: Re: [patch cygwin]: Replace inline-assembler in string.h by C implementation
From: Kai Tietz <ktietz70@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00038.txt.bz2

2012/10/24 Christopher Faylor wrote:
> On Wed, Oct 24, 2012 at 11:07:47AM -0400, Ryan Johnson wrote:
>>On 24/10/2012 5:16 AM, Kai Tietz wrote:
>>> Hello,
>>>
>>> this patch replaces the inline-assember used in string.h by C implementation.
>>> There are three reasons why I want to suggest this.  First, the C-code might
>>> be optimized further by fixed (constant) arguments.  Secondly, it is
>>> architecture
>>> independent and so we just need to maintain on code-path.  And as
>>> third point, by
>>> inspecting generated assembly code produced by compiler out of C code
>>> vs. inline-assembler
>>> it shows that compiler produces better code.  It handles
>>> jump-threading better, and also
>>> improves average executed instructions.
>>Devil's advocate: better-looking code isn't always faster code.
>>
>>However, I'm surprised that code was inline asm in the first place -- no
>>special instructions or unusual control flow -- and would not be at all
>>surprised if the compiler does a better job.
>>
>>Also, the portability issue is relevant now that cygwin is starting the
>>move toward 64-bit support.
>
> Yes, that's exactly why Kai is proposing this.
>
> I haven't looked at the code but I almost always have one response to
> a "I want to rewrite a standard function" patches:
>
> Have you looked at other implementations?  The current one was based
> on a linux implementation.  A C version of these functions has likely
> been written before, possibly even in newlib.  Were those considered?
>
> cgf

Sure, I have looked up standard-implementation of
stricmp/strnicmp/strchr as code-base.  We could of course simply use
C-runtime-funktions here, but well, those wouldn't be inlined.  The
latter seems to me the only cause why string.h implements them at all.
They are defined there as 'static inline', which makes them pure
inlines.
The strechr function isn't a classical C-runtime function (it is close
to strchr) as it doesn't has NULL return on none-match.

A classical strchr implementation would look in C like this:

char * __cdecl
ic_strchr (const char *s, int ch)
{
  while (*s != (char) ch && *s != 0)
    s++;

  if (*s == 0)
    return NULL;

  return (char *) s;
}

The ascii_strcasematch and ascii_strncasematch functions are close to
the strcasecmp/strncasecmp C-runtime functions, but the result of
those functions on failure/success are different.
strcasecmp/strncasecmp would return zero on identity, and != 0 on
none-match.  The strcasematch/strncasematch routines are returning 1
on match and zero on none match.

Classical implementation (for ASCII only) for str(n)casecmp functions
would be something like this:

int __cdecl
__ic_stricmp_a (const char *s1, const char *s2)
{
  int c1, c2;

  do
    {
      c1 = (int) *s1;
      c2 = (int) *s2;
      if (c1 >= 'A' && c1 <= 'Z')
        c1 -= 'A' - 'a';
      if (c2 >= 'A' && c2 <= 'Z')
        c2 -= 'A' - 'a';
      ++s1;
      ++s2;
    }
  while (c1 && c1 == c2);

  return (c1 - c2);
}

and

int __cdecl
__ic_strnicmp_a (const char *s1, const char *s2, size_t n)
{
  int c1, c2;

  if (!n)
    return 0;

  do
    {
      c1 = (unsigned char) *s1;
      c2 = (unsigned char) *s2;
      if (c1 >= 'A' && c1 <= 'Z')
        c1 -= 'A' - 'a';
      if (c2 >= 'A' && c2 <= 'Z')
        c2 -= 'A' - 'a';
      ++s1;
      ++s2;
      --n;
    }
  while (n != 0 && c1 != 0 && c1 == c2);

  return (c1 - c2);
}

Regards,
Kai
