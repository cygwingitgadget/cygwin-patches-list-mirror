Return-Path: <SRS0=TASg=6Q=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 78BD8385B51F
	for <cygwin-patches@cygwin.com>; Mon, 20 Feb 2023 20:20:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78BD8385B51F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id U3kYpYuG3jvm1UCe1pWqYI; Mon, 20 Feb 2023 20:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1676924417; bh=PPSmNNCKKkyhSax58oqughlF4mowztS/Uz32tqxMQOY=;
	h=Date:Reply-To:To:From:Subject;
	b=DjZE/2uBoaYrqrgZ2QVR6NSAAsaW/WsndNSZcDds1xrs6TmQe9xXNA0Eb7DZkIM4r
	 619GhNd9DlLSnmWLvDnibsQpcaRUFdK2GX4Xvlx4eCGejp5Oz8UYDPH7NPgB9PAYoz
	 VKCSajkZdjkpgVvPqyYd3vXVRHKwrVjIA4PLc7WlSlUnt0WTpbBp8HlASBfYyMdtj1
	 eQ/8E3w2hI9zCEbgNRE4KcuQEwppiBXzbAfFDNR7BNA6Ood7CkzRX77QRbnfthdx21
	 qRhLEg2EoTVVpTJcuFSN7wJtjcI9g1B67QDbMblVbY6xDwu/d3TURtKwi4WrIP8+tr
	 Ak3F1luPCRQ9A==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id UCe0pBuRO3fOSUCe0po3D0; Mon, 20 Feb 2023 20:20:17 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=63f3d601
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=vsmOMZeAlzyJapgw8ukA:9 a=QEXdDO2ut3YA:10
 a=OCWz5_UTjG4A:10 a=9c8rtzwoRDUA:10 a=yipANtDfiQYA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
Date: Mon, 20 Feb 2023 13:20:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Subject: Copyright outdated? in Cygwin/X FAQ 12.6 and not addressed in Cygwin
 FAQ 7.1 link
Organization: Inglis
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHFTwg9inxqN7UsctLG3fM8eVz/lhvPHZLosM7DmdYxjTjaI7fA/fkTCWJngRWk1dT/JpFacyuhDTm5jtXwkqtrjenKhtkEdu/QMgtcVZpVctOzB5vHh
 C/QsPFKlizk5azTMqjDiwORhRhkctdiE7HCkHm8WOUrfFduJvFwxtTxVUgJG/C7j2Fbfrr4/679+xqXK5sCWoh0beGZQavhZDlg=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,
[Addressing to patches as that's where we'll fix it, and not a general issue.]

Noticed that:

https://x.cygwin.com/docs/faq/cygwin-x-faq.html#q-copyright-cygwin

"12.6. Who holds the copyright on the Cygwin source code?

Red Hat owns the copyright on the Cygwin source code. Red Hat requires that 
copyright be assigned to Red Hat for non-trivial changes to Cygwin. You must 
fill out a copyright transfer form if you are going to contribute substantial 
changes to Cygwin."

Has that not been assigned to the project?

And also:

https://cygwin.com/faq/faq.html#faq.what.copyright

"7.1. What are the copyrights?
7.1.
What are the copyrights?
Please see https://cygwin.com/licensing.html for more information about Cygwin 
copyright and licensing."

->

"Cygwin™ Linking Exception
As a special exception, the copyright holders of the Cygwin library"

Is that the project?

Or does it belong to the authors individually and/or the project or the "Cygwin 
authors" collectively?

Could we please be as current and explicit as possible in the FAQs once current 
situation is clear and wording is agreed?

Thinking that Cygwin/X FAQ 12.6 should defer to Cygwin FAQ 7.1.

Willing to submit FAQ patches ;^>

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
