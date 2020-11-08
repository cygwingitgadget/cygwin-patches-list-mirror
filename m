Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
 by sourceware.org (Postfix) with ESMTPS id 9CCFD3854833
 for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2020 19:28:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9CCFD3854833
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drW2qfAiUjDp7KyHdklU1JaAud6wyxWY4VMGUl222xcBLdNBgUQgB3/LpbLhi3MhHBiPLInJps/Oq49djQiinWa8DuOn00cBrmnPYpPd7KKxY6nUCW4n58n5OkEqOAE18VTIkKBvFrJ+2skL/T1ezf5dsYyz4LTnadnmjhDH3waWA1ICuLC+aiVNAj6sVIelWnrNGCO2zaBlPAaHhB2OOow03/EiP2bKqwASw14GthTuHvHZC4ahIG6Tk3LCOhoS3lxGu1wFI5kPatQNLH14Qwg2J8BLUJFrgBVpAEk6dy/9HXbRCgsnBSqSDcrS3reRw2db1fLuh+mxAcbpA0tJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdWlJc6dVk8Ph1zzUdmzJFqeh6N91R9JuwSDecuIeHY=;
 b=YnoXMFCqDCMP99/pf6VvlC0V6xUaUQ/Ge0gyyWM7GGUY54/qBL5P8joXgPIZmOzxGNCKeWPk+4q5O/9Q1hz6Svu4PtB1wo0mjPYZYviON3Fv/fVq1yWoGmDv5KxuY8LibP7dKIt3loaSEnaRZCxd0sgpPiIPDMiFgcKJZ2qgsO6VLTBzbSPkRBZZZ421KaXODrzGtR8tlPYz7XOudAvItR8AWCRTOviEtd2ACHAiRbsRO2Mh9iIaQF6IbXBlLlJzFrJxHpkv4b4HMCSb4wLXki+/Fsx5qs/gPM3C+qFDSYZly4LwKDG/3iE1silaUgbliMb8ODb/QgcAP6J1XruEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (20.178.248.205) by
 MN2PR04MB5487.namprd04.prod.outlook.com (20.178.245.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Sun, 8 Nov 2020 19:28:32 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 19:28:32 +0000
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
To: cygwin-patches@cygwin.com
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
 <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
 <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
Date: Sun, 8 Nov 2020 14:27:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
In-Reply-To: <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 19:28:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb4ead67-6e63-458c-f778-08d8841c7a69
X-MS-TrafficTypeDiagnostic: MN2PR04MB5487:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5487E8A824F7E088D8663710D8EB0@MN2PR04MB5487.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaskNzxefn1NgIEwWJTzC7F/SpWlRjCgqqQ2D/MLf5AQnaHcG4R6ZL0OShkSf78kkZbhHxHlPARDQPUtA5MumtiFUl85PmLlLTSnDgWFWCOru6EUTmVzWpVziSBhE5Xrt+MHUiyKW1TvtBnfwZYvKtu6l+MYVycgiMXBkUPRoVpctdX2EuuXl0lGgK6z7hupwRKoRaY2XMiw7+kANh/1LAgCBawQ4lvAW5EsLLZ03kHoNS+RyXvP+NLQPKYmqVl8svGJg1Ysv4ZT1mqBfAVp5A6OjLW0NSY9avAs/I6NUOnpyopFQWvrowvZzPRmIj6ylpFlw4/bLIPMeTwGPKwlu3+eYRdl+1pCnJU/Ez4MBGDINNeBOWmru2pZuG16G4FE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(478600001)(2906002)(8936002)(2616005)(36756003)(86362001)(52116002)(53546011)(66946007)(16526019)(16576012)(31686004)(186003)(26005)(6486002)(6916009)(66556008)(8676002)(31696002)(786003)(316002)(6666004)(75432002)(956004)(5660300002)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iCRCZb/3HcjhRrQI09aOoTHBuhG8CYStASpFEf1tbmb84ULOWj69f0yCKeyvR4nhZJc7js2QIkG1eUqXUdSe4ST7iFV6QE+U8ZsgFzjGAHXVWlwXDaK9vt3GiPP2LDRZAmRxY23Qnluk6E5rdefL85Z7m+5E+nYKCiB6uHlLAkn5cGfyOqAczpv9c7yR5pRyx/GuhVe+Z7Hi5vtAREUdk+9WD7ZC5bUnUvyIrZqp7+E9sIUeOfU+Q2D7v+Fznb2UA+vtpteN7KkHpbBjvl3E7LHl5ufaVppVCMjib5Vx+NBkcCvaUARFXBG9IsRWc9WMcy2UnVDs6IvbDWxHeNvHy7hvoKz8VjQ4IYgshskp2KHPcTibkZB3eTUudOWOaigW2ltR1diLjK2QS6zE1sRwsBgJULt1xCrxhk37Rww5qOoNkG1GTFdF7huwXkFU/p4WTiw1xh6NAUld+4/YeWJK1GK0tHEcJCDtPoK6aunHPqThl4gh5gLRWxgjUw+PNyu4K/TP4BziFROQRwIC3WLClyleyi7uS24i2yekbeJ22J51ZlGOq6MwAUV2Yep/V4EMtiRmqpMmWb5F8uuIWRzaytFxBCh0QOiafxtuE6CXUeRT4NWcIh+OXBvlgimoQFdexCs8IfOgNDiZ+yU7AouUxA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ead67-6e63-458c-f778-08d8841c7a69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 19:28:32.1500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1DlMCnnP4ma/ga+JXGU6OVZWI+I0ZC/SpcuEZXcUcMqirfBNVtviRZ+wE/nvbHL5TbtK+3g5SU1h25uN3Y6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5487
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 08 Nov 2020 19:28:35 -0000

On 11/8/2020 1:52 PM, Jon Turney wrote:
> On 08/11/2020 18:19, Ken Brown via Cygwin-patches wrote:
>> On 11/5/2020 2:47 PM, Jon Turney wrote:
>>> +# temporary directory to be used for files created by tests (as an absolute,
>>> +# /cygdrive path, so it can be understood by the test DLL, which will have
>>> +# different mount table)
>>> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 
>>> 's#^\([A-Z]\):#/cygdrive/\L\1#')
>>
>> This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe use 
>> 'proc/cygdrive' instead of 'cygdrive'?
>>
> 
> That's how I originally had it.  Unfortunately, test ltp/symlink01 relies on the 
> test directory being specified as a canonicalized pathname (i.e. is the same 
> after realpath()).
> 
> Since there's no /etc/fstab in the the filesystem relative to the test DLL, I 
> think it should always be using the default cygdrive prefix?

But there's a mkdir command that seems to be run in the context of the user 
running 'make check'.  If the cygdrive prefix is not 'cygdrive', 'make check' 
fails as follows:

ERROR: tcl error sourcing 
/home/kbrown/src/cygdll/newlib-cygwin/winsup/testsuite/winsup.api/winsup.exp.
ERROR: can't create directory "/cygdrive": permission denied
     while executing
"file mkdir $tmpdir/$base"

Ken
