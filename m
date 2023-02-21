Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 735C03858D1E
	for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2023 09:12:51 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MKbPg-1pDxmf3jVk-00KycR for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2023
 10:12:49 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EEFF8A8079F; Tue, 21 Feb 2023 10:12:48 +0100 (CET)
Date: Tue, 21 Feb 2023 10:12:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Copyright outdated? in Cygwin/X FAQ 12.6 and not addressed in
 Cygwin FAQ 7.1 link
Message-ID: <Y/SLEH6/phijPZb4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
X-Provags-ID: V03:K1:YeT9NFmK++Qc7BmqizUU7FRy0Ff1j7afvzk9JB/ovLNROMDX564
 lwNJrirUKBrA1L8m8EkAJinqLtdpjI7QD8HCiXfitOfhDgp7X7nd+/eP3e0tSmmPlUL5KwC
 G09JTzC3n4Y1jLJ7ugJlzcBX7lF3tmmxv0hIPviNYd5rzZXFGqqhGR+G2X2dLrq5zY9s7ke
 B10A3wwO0vbGzssGXzirg==
UI-OutboundReport: notjunk:1;M01:P0:20oSm3FSgYE=;6kzCExnDc2PglgphxJ8SgFvHwuJ
 MBBAD7m4c2RfjtjMe5Ox8d9CPV9jOsu3ytW2S1MpIwvZzc8lEQHRmom94LzDH4f9n1VpD7HFm
 2y9RjTzbOWm9AXIcL1cUvfy6C3ckvLZr9CHpdOo2DnMmyiqGrskS7HVDBdKdXZ1s/IrIAoo8l
 dK4nVn5mbzRmwR9MDeUkjsR7HB95ZN96U+AdU4WlU27xA6kBo1JXNzf6/rq/rczWlAuZv6Tyf
 kLGoEQVTrz1UAiMJ3R1kW5dJT3gN/MoEivzt4NUD5uNpqtbrHNZ0TAx1BR/NAuQwidRvWGZkf
 vxWQp53qZ9A6lQaeE59TgQwYUB2f8y/CseVlJGKNvY53R48uf6RvqkxRU0znSTW3NX5T4CcLa
 IltfoD7iMEJCfmsuhhQ3BrlzKqvFXW1dn8v5NLvagSHZ2Y35/HOut3HfHYDBbanJBwoxPhDLp
 KJH0UGsYDm3I8jsPBr+ySM8kKVBePmOvwuWCuopkV753SbwLxc8rIy21+hr3MklpLOd6EL/P1
 TjTVbhmkyY+jf8FlM6quLL0EGse7NRAqcGWuYx7mozkfjA03rBeY5ZP+uT0u1bjfUgbWhmIFX
 62NAwVRQKNtdybMr7I/vMIFU1ZjQq4dbu6AjGuwpAHbsZ6qFiXCYs5/qtuawGfP7dDi6IsE+P
 2ZWug38ChsvUKoqe50vdU9tnmSDOD8ueqV6+pVAHiw==
X-Spam-Status: No, score=-97.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Feb 20 13:20, Brian Inglis wrote:
> Hi folks,
> [Addressing to patches as that's where we'll fix it, and not a general issue.]
> 
> Noticed that:
> 
> https://x.cygwin.com/docs/faq/cygwin-x-faq.html#q-copyright-cygwin
> 
> "12.6. Who holds the copyright on the Cygwin source code?
> 
> Red Hat owns the copyright on the Cygwin source code. Red Hat requires that
> copyright be assigned to Red Hat for non-trivial changes to Cygwin. You must
> fill out a copyright transfer form if you are going to contribute
> substantial changes to Cygwin."
> 
> Has that not been assigned to the project?
> 
> And also:
> 
> https://cygwin.com/faq/faq.html#faq.what.copyright
> 
> "7.1. What are the copyrights?
> 7.1.
> What are the copyrights?
> Please see https://cygwin.com/licensing.html for more information about
> Cygwin copyright and licensing."
> 
> ->
> 
> "Cygwin™ Linking Exception
> As a special exception, the copyright holders of the Cygwin library"
> 
> Is that the project?

Yes, that's the Cygwin project, not the distro as a whole.  All packages
in the distro have their own license.  THe above is strictly only about
the Cygwin project license as defined by ...

> [...]
> Or does it belong to the authors individually and/or the project or the

https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/CYGWIN_LICENSE

After Red Hat stopped selling the Cygwin buyout license, Red Hat changed
the license of the DLL to "GPLv3+ w/ linking exception" and handed the
copyright over to the community, so the copyright holders are the
individual contributors, most of which are mentioned in
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/CONTRIBUTORS

The former buyout licenses had a pretty long lifetime, so it was
necessary from a legal perspective, that contributors passed over the
code under a BSD-2-clause license as long as the buyout licenses were
active.  This time has passed in the meantime, so we don't really need
the CONTRIBUTORS file anymore.

> "Cygwin authors" collectively?

The project doesn't "belong" anybody anymore.  The project has copyright
holders.  Those are the developers contributing code to the project
collectively.


Corinna
