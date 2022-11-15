Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 06275392AC33
	for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2022 10:46:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 06275392AC33
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0nOF-1p908N1b1B-00wlBN for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2022
 11:46:50 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A97B9A8088F; Tue, 15 Nov 2022 11:46:49 +0100 (CET)
Date: Tue, 15 Nov 2022 11:46:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Message-ID: <Y3NuGWbczdW5f+rC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
 <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
X-Provags-ID: V03:K1:dXTHHYZm3VoWdpXr9CcgwS13iksGrR0RjW7vd5DjzwEsgO86Wts
 i4KPw29QlXRw5gqWx115pdFSfPSH+4GX4kz3EP5HcQoHjQx3ECpIhgueiFOTETF6+13I3z+
 CWmAwfx6wrzV8a3geg/3FQ+42gs41Ujo7uWbxklcuocLdsC7wPd6oXGyJWGCb6Qx0dAVCUS
 Bq+P3GkiPPaFFQluNdNJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cVpKO4zi6ws=:ZW7VQtQTa4aRM7FBFbpHvC
 Dlxo3uoosIjuPylHg8b/91HgiRJ+InUKTSYm2apkmvcZPiu0LtzRqjG7YtzyKoNmF49hcEW4x
 HEB/ClEJiYebRgsFItxj4pm8RG0M1RD232ZgDF2mCKmp/R/VCAsvFRawIAbfcPjaIpriEmiVK
 m9RyM9FrZkreMOiw+yz8VfLNQ8r7RBLBoGI42+nAVt/lfqQklBtsPqMPOyhyXFCWkZI/VadVl
 giN9zR0W7ELnfG9LtWuyOloD7KJ3hj7UjF2akXhrQ53qLVn/L+TwxTlpFcTjOJHvlDrehAToT
 tSuEvf89Sca484mXG9lUJFI2MI44vVbFBqBOJBCsYNOrPlh/NhRYbpB57Rs3j3U1yku7qOVeW
 VdnC59FsNYcBoPU7rtTV4lhG/4wfH/Uwta93D7ggUkupKc2nKXa3zYFWg0sAsyqDg4BjJvs8R
 EhwcvWqXEXcdoykWY59LY/ScE43/4fPKjM6Kvtci+mLZKipLYC2WtIbYgRaihyiIUyKZK+WIM
 IJsjqnl4Zwv6gQW07uBJ02PCcl6wNceUFphaYG619+hsvNNB2t73j13kA4hxBa9f3YM0H9XyF
 aB4Pmu/XvevG2G/K2pFYHdbogssjpPzNm5bf3O80jMKajAhU3whl4h/lT30S9RbcNkBnjLnZ+
 CSTBjlSRzAzEmJB+/qIZ+R7/ocR1t19zCQD1MdA4NW9qLnCta8WYmF+lYEm8LVlUNQbGT6FOn
 KDwIGAJd+D5Xb1+1AXfSsSelTHd6gsUTPcU7muARrJfum5BhkbHvXUIoghrY6ut2u10Wmn2/n
 0mgHuWvHOFnOnhatIE1eGkglF81zJr8YdXE7k7Fscj2ZBPVEs99wloHx6AqgI08jnCzWosYLI
 nZKnPRALochE5k7AsKtUR2Bjt0FDCnHnFWCtwmUcmwHhCVoUvZrDBGSMp5JSnfkom4vydJ2Vh
 1MKuQAgpvKEmUWLwcJjSGWDzL9efMiS2ledDSfrol0NeTSQkKBiu26ceKIInHEWaaIMfxFBUq
 fim/edYZ8t4075jpNaIJmRxk/d+yHvKv35hfADZGsyqgqnRBVrjl5hvDNrJjUzNtQVDoJz+I4
 XO7WklymK1SXh8Q7IqO72O5Osf/IjcglO3q8ALwEIYrd3LLYiAwxsn4fmH3/rcpKSQzsh/j97
 DanxiXaWPOD6YN4tC0sX+0CNMf+8W+4c5jI0XkyYFzDaEt1zF8nzKgFUzk6zwYTGdRHMzoPIl
 fmPQ2iuq84EpN7NSoM/YEgb6q8PRzs3u3XicNbuRAoUNN7fgDFr6YFyZUgKL8FLbXgjYY0OC5
 GkoauuzXrorMwmZwzeP/2+dFfZVSwg==
X-Spam-Status: No, score=-95.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

the patch is fine, but...

On Nov 12 14:30, Jon Turney wrote:
> On 04/11/2022 15:29, Pedro Alves wrote:
> > On 2022-11-04 12:53 p.m., Jon Turney wrote:
> > > +<para>
> > > +  (It may be necessary to use the <command>gdb</command> command <command>set
> > > +  disable-randomization on</command> to turn off ASLR for the debugee to
> > > +  prevent the base address getting randomized.)
> > > +</para>
> > >   </answer></qandaentry>
> > 
> > Typo: debugee -> debuggee
> 
> Thanks for catching that.
> 
> Patch attached.
> 
> > Note that "on" is the default.
> 
> True.  But the API used by gdb to turn off ASLR isn't supported by some
> versions of Windows.
> 
> This sentence could be a lot more explicit about all the details here, but
> I'm just trying to be brief.

> From be24c9b69e72648690a477fd2f15b0a9c6374713 Mon Sep 17 00:00:00 2001
> From: Jon Turney <jon.turney@dronecode.org.uk>
> Date: Sat, 12 Nov 2022 14:16:36 +0000
> Subject: [PATCH] Cygwin: Fix typo in FAQ
> 
> The consonant in 'debug' is doubled in 'debuggee' just as it is in
> 'debugger'.
> 
> Fixes: 8c68a8a4

It would be great if we could get used to using the same syntax as the
Linux kernel project to document stuff.  I'm trying to follow their lead
for a while.  For fixes to former commits, it looks like this in the
kernel, at the end of the commit message:

Fixes: 123456789012 ("title of commit 123456789012")

Yeah, core.abbrev is 12 digits.  I'm using this setting for quite some
time locally.

Anyway, please push.


Thanks,
Corinna
