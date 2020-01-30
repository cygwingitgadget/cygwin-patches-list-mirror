Return-Path: <cygwin-patches-return-10034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102956 invoked by alias); 30 Jan 2020 17:01:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102783 invoked by uid 89); 30 Jan 2020 17:00:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=irc, IRC, H*Ad:D*edu, H*r:404
X-HELO: NAM10-BN7-obe.outbound.protection.outlook.com
Received: from mail-bn7nam10on2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) (40.107.92.109) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Jan 2020 17:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=RImy2MsnuUmRVGxKnZsjMylWXF7nGxLMnxg1Y6eXcD131B/G9+lFLDycPA/zNcVyimPqQyuyPDqFv9mcrMJO3xh3DMe4wZ/DeprYiu2xJEwwJNl0W38UnrohzvIEilcCNU4w1zp2xy6EtYewAZrwG5+1vsRCImgGWv+dK+1RUe4gKblaPW0clLKn+7np5sIRC5iu3qP/+nnsE12SoIeZhpRChtx0ZP4WebKryS1Sr15S5NGjFzwrCoYoplwsfyxklqRALSuMgs51lyPne5h4zINC3njuE8faFyzUA18L0IhzyZduSfIkgBzWHJgwJ7BoWyvbf617m4VCLTJGuT5qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=XiCA+/E4lS12TZyARlkRhhGBGlccqsSN4nPLufLgCHc=; b=od2O1noBpv27Fb/CJJ3NWAtLG3QSnfMt/adcULLqREICmoYGZeuv6kmIe7yzhrEUjxEWM3xpIrdhJcCvfFf72kVIkpCQc19d8n8lx8qTsjg/jbU7YKaPAk6+uzfHthAKnUXUVYwKtxKbunPqBazqGyzuep5aW9ffpJKzYqd1iv+06H05zJK1JGXfUnqYViLBnJL09fDFMZCK0o9ZDakG5gWAK8uspg2gbHXpTMX4ArPWGDleYmAZvYCgG7etb8r17wNxYpQII+PMQRCYpkBXMvR90zbVNDJEY0i3x25TUKYb4ws43dBoXbZl3CIXKU0KsWaOISZQSeM8PiUA0a9CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=XiCA+/E4lS12TZyARlkRhhGBGlccqsSN4nPLufLgCHc=; b=QfDDG1r0x6bZgJs6a/DDHblfp4v1TE+ZnjEBTlXHfkPA/pporTic2DnxNAHfndk02t3A3NbI2q0HKiHUO7D10JTsGIfDYFkn4HxkPBT3E/5eedFBZ8fOVDED45YQIoAMavbex9Yx0meXEIxA8IMV2MXWgNW6CEU1q/pj3wWOXsw=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4458.namprd04.prod.outlook.com (20.176.104.14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Thu, 30 Jan 2020 17:00:33 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020 17:00:33 +0000
Subject: Re: [PATCH 0/3] Some O_PATH fixes
To: cygwin-patches@cygwin.com
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu> <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu> <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu> <20200129095234.GJ3549@calimero.vinschen.de> <20200129142240.GN3549@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <ac9e93e4-6e6a-694f-359d-680695873b1d@cornell.edu>
Date: Thu, 30 Jan 2020 17:01:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.2
In-Reply-To: <20200129142240.GN3549@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: kbrown@cornell.edu
MIME-Version: 1.0
Received: from [10.13.22.8] (65.112.130.194) by BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 17:00:32 +0000
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
Received-SPF: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-MessageData:	qvn49kGTixgxZtO38MXnfwXq70+i2LN1g96DdZSrIjwbMNzDNHGZKLfy1o1Ehjhou34gr5Fcq74p3h+oZvtbVvlAGdRQP/mQjWYtLLX/8plKvS+GHQ0brN1SGVQlD0pENxYvsEW3ZsgRVWxLZZ+HOw==
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7J5qU06uIZY/Yby8JK9aDLF0XTqXPsCD0bEe6Qt0hOeYsanIDsjtZ5mWOTj0vWo+ZoE1L7XBxc0s2gD2nTn7A==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00140.txt

On 1/29/2020 9:22 AM, Corinna Vinschen wrote:
> On Jan 29 10:52, Corinna Vinschen wrote:
>> On Jan 29 03:08, Ken Brown wrote:
>>> On 1/28/2020 3:48 PM, Ken Brown wrote:
>>>> On 1/28/2020 2:01 PM, Ken Brown wrote:
>>>>> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
>>>>>> As outlined on IRC, I found a problem with the ACLs created on new
>>>>>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
>>>>>> return the real permissions in stat(), only the constant perms 0666,
>>>>>> kind of like for symlinks.  I didn't have time to look into that yet,
>>>>>> but it would be great if we could fix that, too.
>>>>>
>>>>> I'll take a look if you don't get to it first.
>>>>
>>>> Two quick thoughts, and then I won't have time to think about this any more
>>>> until tomorrow:
>>>>
>>>> First, I wonder why in fstat_fs we're not using the stat handle (i.e., pc.handle()).
>>>
>>> Ignore this.  I was confused.
>>>
>>>> Second, in the call to get_file_attribute in fstat_helper
>>>> (fhandler_disk_file.cc:478), why do we set the first argument to NULL instead of
>>>> using our handle?
>>
>> The handle is a pipe handle, not the file handle, and the permissions
>> on the pipe handle were not reflecting the permissions on the file.
>> The NULL pointer was trying to make sure that the file gets opened
>> for fetching the security descriptor in get_file_sd().
> 
> I pushed a fix for the permission problem, but I didn't touch the
> get_file_attribute() call in fstat_helper.  If you think this can
> be further streamlined, go ahead.

AFAICT, the handle returned by get_stat_handle() should always be pc.handle(), 
not a pipe handle.  Patch on the way.

Ken
