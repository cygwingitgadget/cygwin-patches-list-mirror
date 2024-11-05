Return-Path: <>
Received: from inpost.tmes.trendmicro.com (inpost.tmes.trendmicro.com [18.208.22.119])
	by sourceware.org (Postfix) with ESMTPS id 0B103385735D
	for <cygwin-patches@cygwin.com>; Tue,  5 Nov 2024 19:24:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0B103385735D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=tmes.trendmicro.com
Authentication-Results: sourceware.org; spf=pass smtp.helo=inpost.tmes.trendmicro.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0B103385735D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=18.208.22.119
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730834659; cv=none;
	b=V/LaPrdlRWGeOuOh9dCHca9MX7JkNcoj7jtZ9+R9I3mtD82yQDCC68X3iGRxPkddqekFNkQgRl4qiQibt962sKZ2ijZP8rXEs7hU+uD7fafRZT4keJi6XBciGJfCf3hVJ1CziF2rVDsbBF/Fr6wZfqwV7cLVz54rOuFDMszLUUI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730834659; c=relaxed/simple;
	bh=f3VLo+7tiDB8N/De5Mv0e8JjmFED9yGmVu1LzUK8PU8=;
	h=DKIM-Signature:Date:From:Subject:To:MIME-Version:Message-Id; b=mP9NJbvhqSlQ4JgI/IMUK4Ipehxh42htHQXgFVeMXoFy8TZRdVKGPVMvdk9pk+Ar2BnGGRh44WK4j5TPzvclvp5bfvEYC1Kn0RfQFcrB6bYh0pphhwa6IDF2mOH4+/QBa9xTvVhxm4hqaYeOkihoBDinyyFeILTJles/07DX28Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by inpost.tmes.trendmicro.com (Postfix)
	id A30F7100003BF; Tue,  5 Nov 2024 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmes.trendmicro.com;
	s=TM-DKIM-20230630155016; t=1730834656;
	bh=8ros2vTZICiwaNj1DFUiW5SHyRQldtDiZ3VZtXY28Hg=; l=4992;
	h=Date:From:Subject:To:Content-Type:Message-Id;
	b=bJvALClp39XTXl+RJBCbVHJzglWIHvJXx+zXEz2hlL64bp9ZFWg8jtVSwNsHjTuYh
	 LY3mlz2UvSigLqMZzaDY3FO1wrGWxcLB3fWK7YGqmvnVxcay7ANlrMQdqC9dZnMGw9
	 97jhYbkLuPSFbR/PzY43HPFhSZX8BcbPD+z2ntmI9CXwxr2Q44cqCc5E8aQ0RC4o+h
	 l9eQCFCipUOJAMwBn3V6klWwOLbDsj4ITtuuVbvDD7IPUgG6MSnMBNsU7yMm0GKc7g
	 clc179tVUrMq2VLlbfiuxa3MGdpIm0yX2DKZNOZSF3o28cFI0X1oxRWmcw/a57pBYM
	 suIH0SCT+/k4Q==
Date: Tue,  5 Nov 2024 19:24:16 +0000 (UTC)
From: no-reply@tmes.trendmicro.com (Mail Delivery System)
Subject: Undelivered Mail Returned to Sender
To: cygwin-patches@cygwin.com
Auto-Submitted: auto-replied
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="D9D521000030A.1730834656/inpost.tmes.trendmicro.com"
Content-Transfer-Encoding: 8bit
Message-Id: <20241105192416.A30F7100003BF@inpost.tmes.trendmicro.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,TXREP,UNDELIVERED_MAIL_SUBJECT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a MIME-encapsulated message.

--D9D521000030A.1730834656/inpost.tmes.trendmicro.com
Content-Description: Notification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<chinesestudies@cuhk.edu.hk>: host
    cuhk-edu-hk.mail.protection.outlook.com[52.101.137.0] said: 550 5.4.1
    Recipient address rejected: Access denied.
    [SG2PEPF000B66CE.apcprd03.prod.outlook.com 2024-11-05T19:24:16.285Z
    08DCFB7F93F934A4] (in reply to RCPT TO command)

--D9D521000030A.1730834656/inpost.tmes.trendmicro.com
Content-Description: Delivery report
Content-Type: message/delivery-status

Reporting-MTA: dns; inpost.tmes.trendmicro.com
X-Postfix-Queue-ID: D9D521000030A
X-Postfix-Sender: rfc822; cygwin-patches@cygwin.com
Arrival-Date: Tue,  5 Nov 2024 19:24:13 +0000 (UTC)

Final-Recipient: rfc822; chinesestudies@cuhk.edu.hk
Original-Recipient: rfc822;chinesestudies@cuhk.edu.hk
Action: failed
Status: 5.4.1
Remote-MTA: dns; cuhk-edu-hk.mail.protection.outlook.com
Diagnostic-Code: smtp; 550 5.4.1 Recipient address rejected: Access denied.
    [SG2PEPF000B66CE.apcprd03.prod.outlook.com 2024-11-05T19:24:16.285Z
    08DCFB7F93F934A4]

--D9D521000030A.1730834656/inpost.tmes.trendmicro.com
Content-Description: Undelivered Message Headers
Content-Type: text/rfc822-headers
Content-Transfer-Encoding: 8bit

Return-Path: <cygwin-patches@cygwin.com>
Received: from 171.211.41.102_.trendmicro.com (unknown [192.168.197.243])
	by inpost.tmes.trendmicro.com (Postfix) with SMTP id D9D521000030A
	for <chinesestudies@cuhk.edu.hk>; Tue,  5 Nov 2024 19:24:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1730834651.158000
X-TM-MAIL-UUID: b942980a-1cf0-483a-948a-3dc03f0ddaa9
Received: from YM-20200820EAUR (unknown [171.211.41.102])
	by inpre01.tmes.trendmicro.com (Trend Micro Email Security) with SMTP id 26D2C100003D8
	for <chinesestudies@cuhk.edu.hk>; Tue,  5 Nov 2024 19:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=cygwin.com; s=g; q=dns/txt;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	bh=3dtf2RuELPmFPx3noWPn3Psj8aGxPjprZisA9gFpJtY=;
	b=FEXmBTJGa6CCfRRrjUAL/yVZ6WZ1qpXaM3jKA6ND1nw
	 mXCA8QOI3LpH5xhODpwgQeMXg/Yc4vh26zmpJsyQpqQ==
DKIM-Signature: v=1; a=rsa-sha256; d=cygwin.com; s=g; q=dns/txt;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	bh=3dtf2RuELPmFPx3noWPn3Psj8aGxPjprZisA9gFpJtY=;
	b=pC2PVmOJg+tDSrojQ5XZ9snzCf2zDOoAnHA246LE3Am
	 yyLMMsVf0WHkRFhi2/Rocs3ueYruFj177pN/VvQOsgg==
Message-ID: <482657381378$10f2a526$3cf0a3bc$@cygwin.com>
From: cygwin-patches@cygwin.com
To: =?GBK?B?Y2hpbmVzZXN0dWRpZXM=?= <chinesestudies@cuhk.edu.hk>
Subject: =?GBK?B?u9i4tKO6?=
Date: Wed, 6 Nov 2024 03:24:09 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_556_E02B_76DC5903.0C81245C"
Thread-Index: AdW0g4BaTObLLKrs9hi/Q6w6/G9O8Q==
Content-Language: zh-cn
X-Mailer: Microsoft Outlook 16.0
X-TM-Received-SPF: Fail (domain of cygwin-patches@cygwin.com does not 
	designates 171.211.41.102 as permitted sender) client-ip=171.211.41.102; 
	envelope-from=cygwin-patches@cygwin.com; helo=ym-20200820eaur
X-TM-AS-ERS: 171.211.41.102-127.5.250.11
X-TMASE-Version: StarCloud-1.3-9.1.1028-28778.002
X-TMASE-Result: 11-42.194100-10.000000
X-TMASE-MatchedRID: 9UpAzepUATnI8/P388MdKkIFcV2lbA2s+hNV99ZVgtic1imbtWmuUmpL
	MWuYw53HY9UyOJW3LQmwrYif21Xkb4RzCHvofijvBVUJBhhuhNRMU2WHpxO/oBiZeQd/9WLuQOD
	uf9DLUWzihIPBgxhKLIRPwztbA3aXTelz+w/IDRfEsqMxUyMYzCI4aG5I5YTzr47oO69ABZKRp7
	UW00gJR7QCyGlvf7Cvml4l7FpDpmdqr/Mcc0RpuANot0NedUFt3B3tShJpI+1CBW2lGi6tNOihC
	Tu0kel4CNuyDWZimKW9lzVGWamWgOH7RHkgEpGyqUwMl4qqE1tWPx536TZMQEY9qhKq1vAEx7Ph
	4M1nMc0X5gP22I7zH6xyCT6b71y1voAhU8hEVKEJZr5wg5i65SP+W83OH43NdggDIoBIEEYJK2M
	K45H+GA==
X-TMASE-SNAP-Result: Not
X-TMASE-XGENCLOUD: 0854dd3a-c33f-4a83-a8fb-b428370ccf28-50-0-200-0
X-CUHK-TMEMS-SPAM: 7
X-TM-Deliver-Signature: 108B6EA45FDD4D47A2A235CA7E9EA09B
X-TM-Addin-Auth: JTwyiO5lz3W5k1ci6ApyH4KVFdvOXRLrF0U5q48kcMvWvMaf7xcGeUz+Z9G
	DDSYTWxyKeVDLMxbNAjWBL/LPhe3ZDkghmsP5XM/r2mkYzZF71by5LubC8axzILTcEYXMc1ce5P
	IYxCShPiu/EXccuzYHwirlbRkt2WGNcnj14Ek5zNS7tNlWzWGvbMCtK1wsc6OvXPqxPBeZB9ZFM
	aoDsWqD4CSgDSqfc1wHXfzWrshsbaPb1B1FKL1IMzghUlxIeRwrs2cI5ZzR0JPCTur/oagP4Kpe
	3a3efIckd7z+mec=.cBcCwoMsy9IfJtocAzPJKYnxkBaZvNLD+Gycz5IPPIR2dOOndReaMI3Il6
	dxPI2Pck0KmSRKi1Mcr1vVcnqXDiCtxAstXhQVsErtsjrpyViFLY8FrGVtc8tSasJ9K41tE/BAi
	G+ruTwnAnaHUlQw05+SObnTENZgdxAohXrQaV014KaIAX+t851TDG5IF5Y5kp84s5LvgZKYgjCG
	Ex97EDzx7oF2lpjz29lSIFhjp5BhyZX4P+GSmrcheUCjCIvQzQ6M6WBMt632poZLxeVUXYy/ulh
	2msvO5jkQv5KkiQIgTUQ1U2HMMHrJR+mjSI13WEdIJhArjpf2DIyp3jFUzA==
X-TM-Addin-ProductCode: EMS

--D9D521000030A.1730834656/inpost.tmes.trendmicro.com--
