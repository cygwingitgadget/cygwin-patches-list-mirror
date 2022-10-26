Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id CB76C3857806
	for <cygwin-patches@cygwin.com>; Wed, 26 Oct 2022 08:13:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CB76C3857806
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mz9pT-1p1RYm3VEB-00wCtF; Wed, 26 Oct 2022 10:13:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AEE18A8095D; Wed, 26 Oct 2022 10:13:38 +0200 (CEST)
Date: Wed, 26 Oct 2022 10:13:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
Subject: Re: [PATCH] Fix typo in faq-programming.xml
Message-ID: <Y1jsMppSUV5oH++z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
References: <6a50dd6a-e805-bbf0-200a-25a1892bfa5b@hamishmb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a50dd6a-e805-bbf0-200a-25a1892bfa5b@hamishmb.com>
X-Provags-ID: V03:K1:PbGoDeJu5TX5qzXcTwtSISYMnQFUi7Tf0Bnt/DXy1tfo97mtFTC
 mXqgNPIEpWB2T9nKQeCItvkP01CkqBMa70BSn5PDfLtGb1thsuuUaouIqRZ3BvexKjWKcsi
 ZHWcEYuoPcsE87AMq5uoOYpXQGVAwQ/QxV3GVk+Kf4P7aEbbx8Jbt+/4UUgyctlQAN2OEQE
 C0XAmQfAo4+3bd0rfNaeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yLI1/yITjQY=:j335flQIvlKyL0sPSN+K5A
 cmMpTBgM3jeIbnVtDo73OqGhSPK9tb7uFNuBwXV46VCT/6E47FaY5GKdyUKPQvghS9XpcH9RP
 3vEI0zj1/f9XHKt2jz9TsL+wk8hukDxdlI/D5tGsICag+7Wz3LSgQ+if056MyM1inY34u1CS4
 wW8FGeoBBHGHnOlMewaxbVV/YVozZObQsGlGitU2wfIVY+lN+mbU+WNkJbr7jlZ39Bo6WyDoT
 7Gr1mTguc/vqi8aq1ViIvnNVzcPfeto82TOcJrr5ihsC8rHNja0/pcRB9ib2gKomh7dtcMgr0
 n+AnepB5eY+zu/cT2k7Ms2EGNe/vl+EVNtBPF5gFcuHHeIvFZM6pBWbY7vohQ+/2wUHk7ecXt
 wz2yqNZQ7iTXzLg3y4pbAQokX8gZF/md0nfOGaGm5bSb++GCukGYeGfBqWDnoGJdL1b5T+lR/
 B0X1Sbw5LjALsR0urf8Fj+DokItMwbI82NkcXUWmga6CMW/qwJ5OGAlTPDfBwIkUxVnsIUdEo
 39T/5boPKOFnNQS2I3jkYuHCBQvVIXdCFp6Y6e8Kvc+6kXx5MRP5BieCJ642gFYEqLgzcvnsV
 ggWa1MGAd9siHWumnwj7gKhsY5XNEk5fY3eNgmnqPeuLD+bx1Njq8V02BrP6sK7IuQp4mMmEN
 v3voKQasbxltXXQ9CtQiMVpDFjsRHVu3t/A2lotZKR6x+0DNjxtOm8T8e/OyQmHW5pStbEjyU
 /3KZro+UbuXA0ihURuIC+5bqsr6CMRTGRPi481eWxci/G90qsU0VB408AzLZvwGTBmoltyIh6
 VtIY2ErjQ3hIHSF5Ld2wMDkHW7bUw==
X-Spam-Status: No, score=-101.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Hamish,

Thanks for the patch.

On Oct 25 19:50, Hamish McIntyre-Bhatty wrote:
> Hi there,
> 
> This is my first time submitting a patch over email, so hopefully I'll get
> it right. Are there eventually plans for submitting merge requests directly
> with git in some way?

No, but by email is usually simple by using `git format-patch' and
`git send-email'.

> This is a simple one-line patch to fix a typo I noticed in the programming
> FAQ. Patch follows below. I follow the list via GMANE, but to make sure I
> see any replies, it's probably best to reply to cygwin at hamishmb dot com.

The only problem with your patch is that all this text will become
part of the commit message.  What you should do is this:

- Hack your patch

- Commit it locally with a headline, an empty line, and a bit of
  descriptive text as commit message.  if it's an obvious patch,
  the headline may be sufficient.

- git format-patch -1
  This creates a file like 0001-foo.patch

- Now, if you want to add text to your mail which is *not* supposed
  to become part of the commit message, open the 0001-foo.patch file
  in your editor and add the editoral notes *after* the line consisting
  of only three dashes.

- Last, but not least, send the patch to the mailing list.  Assuming
  you did set user.email in your git config:

  git send-email --to='cygwin-patches@...' 0001-foo.patch

Do you want to try that or shall I push this with just the headline as
commit?


Thanks,
Corinna

> 
> Hamish
> 
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
> index c2c4004c1..7945b6b88 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles
> automatically.
>  <question><para>How should I port my Unix GUI to Windows?</para></question>
>  <answer>
> 
> -<para>Like other Unix-like platforms, the Cygwin distribtion includes many
> of
> +<para>Like other Unix-like platforms, the Cygwin distribution includes many
> of
>  the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
>  and Qt. Many programs which rely on these toolkits will work with little,
> if
>  any, porting work if they are otherwise portable.  However, there are a few
