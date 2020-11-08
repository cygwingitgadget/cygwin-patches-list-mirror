Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2129.outbound.protection.outlook.com [40.107.243.129])
 by sourceware.org (Postfix) with ESMTPS id 7A6ED385783A
 for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2020 18:20:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7A6ED385783A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvm/G0uQB+OSoL/obYTdjKDyR/f92MHrirrwsoHu6zNlVzNODC2/Ae4DWb1jV8giJYHZ1VUdPBGZ7bIbNAg1vxHtDRA3z4hPWzTkEB0WCy1/l7VX4coaV1z1x1+sDCEpJF9BHNVUoSgnUQuUX5FDSvBOqCA1UYH309w7UPgqn3pK8zg2xMME4pCHbYJRAxXz7Q7/NLzGCc9MvQ6gXmXUWvIpwr5QOFDzaob7/qTQNhddbb6dIGwI+CYOmlxUZFOL1Z50ak7I2wwoy77FQaaX8OJaLFAAx6k8MwabNXoktN6X9NbnVv1k3x3Js71xLWbjk0OSzwCC4WGXwFWl3qsKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsS9iHmPnwHs+s8E68t2yv20nZFsjWtoT48dTW7Hz1I=;
 b=NbxCwTsQY8cz0eb4JgNeDmAA1WcxRrHI9D4a8kuHvvOWmnSc92xwIxVkbMYH/OstVxsbWfpEOm9OK5et3pkPZEgCOHvjgf8zNJWbYAi4bcAmNGABY3AgDLW6+/jSTuKMor8RUA70CAdWFVoIJUGiTjIj7MEC4PB7AuStRizaeUISLn5bdcordEGn5QiImmiir4PJR9jsDLBzPQO21Np7mSg2pWJEVEwLnKgKDR63nROjH5PS432gtbSq9G97aMiVzjgcQDOUdN4LlIV4vFk7xKsyH2EiWRY+vnRMZVVicOCSQsiaUxWg1c1KMGwZy5xQJSLffiCaZzC6ePNbtxfxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5567.namprd04.prod.outlook.com (2603:10b6:208:d6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 18:20:30 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 18:20:30 +0000
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
To: Jon Turney <jon.turney@dronecode.org.uk>, cygwin-patches@cygwin.com
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
Date: Sun, 8 Nov 2020 13:19:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
In-Reply-To: <20201105194748.31282-12-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:20::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 18:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2a644c-bdf4-400f-4fc2-08d88412f938
X-MS-TrafficTypeDiagnostic: MN2PR04MB5567:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5567E3B0E9339536144F14A3D8EB0@MN2PR04MB5567.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8slyfQ8PB3u2usD1fJlGnpipdp48bRz6oXkYbJ6fc2cI/okYqyKwSD/0l8ML4RDNDyvAtvOAKTRfadQCEYPMvjLaZpMP+8WIQc56Ui3S6XAo+qER23YYdPcqVxG2IeXsfO6cFoRRm5LaSpbMfc0nZMNRic1Za4UvmKYqKbHKnkPH+xgBXQv5rFTlx8tnQOkV9wJ2KwqSFeAfcA98sTnr7b2UQ23UNTah9Wtop98DtY81NrUfMu9b+JG46Rf1q88DmOvZGdruq3qonGur3xvJ0fTi7M/R3stWdUopEyIBLiCYERl+DxHLqZOZPdBfa0FhUrR3weeAcacHjt8EZiw6g6skQBP7wjZLEJamnb37aL2CBLuJcn6SOcI2T+1JD6x/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(53546011)(2906002)(956004)(86362001)(478600001)(75432002)(8676002)(66946007)(2616005)(8936002)(6486002)(16526019)(186003)(66476007)(52116002)(31696002)(66556008)(36756003)(16576012)(316002)(786003)(5660300002)(26005)(6666004)(31686004)(4744005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /7oDRalxkAIM6lnJnLT+nzqPR0raAd33aQnt8SDTLmZ7PEYCm9bJecmzV34/JWzoGR1jZFXK715B0L9loayLiS4NmJS0opSgD1yYwCH9XXQ1pHjILKdTGF9jML+f3kx7gC1eRRSEBcAugpJEGORnZwNaU7kxkBWAm7bRGru5P9wE51kJOQwCWlIeAtA7/46ZC7V+OJaccqgajMPMoZcT27TuMrzpnm83YONFwQyiV+rErvwEK5j9NVsXM2GGi8e5WFFiDx75vi+Z/pr3FWukfhBKkMw05wDf4hHlwVnGDvrKMhlukiPR3Ao92CjCV77IwCnkAuTlt/OnN4hR/jyhdEHShiDff5RbfFmviMbYdrb4TH4T1yvZZOZ1VTH2lVOm+VhgGAFRQwMvDpbsJZ2474NvoWHBuaSFzBxUd6LyFuPuwVuD/mLbkI/r+mSSbgRIHtC3Nv1nl2IN9cyXqqz8g2iHE1bEar90hl1q2k4NTdbtqjgiP6F2yhBN2xNsuMHOrnP2KLXpZQwVW15Jo82P0MCg1qegETuqLT2Vlbso0A8qTud2Ohrt+e1S1So76inJ5AgW4T7uObA8KgfhPnPspIZf7yoeN1b2qr7iE9qW3xvHAiXwE/eSNbtKboZy6TgEGp6UM5Mgvy6NXo9HpxBRpg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a644c-bdf4-400f-4fc2-08d88412f938
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 18:20:30.0768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdl2fNlZSzQ7J7seO+VJcAZUEDbwbZZ03iJ5XGC1WQuBRR8u9S7btE8KGBwo3PUif87WqhTRU3sZq6YwiORX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5567
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 08 Nov 2020 18:20:33 -0000

On 11/5/2020 2:47 PM, Jon Turney wrote:
> +# temporary directory to be used for files created by tests (as an absolute,
> +# /cygdrive path, so it can be understood by the test DLL, which will have
> +# different mount table)
> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 's#^\([A-Z]\):#/cygdrive/\L\1#')

This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe use 
'proc/cygdrive' instead of 'cygdrive'?

Ken
