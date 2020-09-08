Return-Path: <kbrown@cornell.edu>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750098.outbound.protection.outlook.com [40.107.75.98])
 by sourceware.org (Postfix) with ESMTPS id 9F8C83861930
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 19:05:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9F8C83861930
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmidKE7iHrJvmIQcp7k0xM7oPEZA84On4kycEvsx+cfK6py+IkvCP5ynI4UdT3UfZ5Ubrx/O64bO1JlbsNDgFCFJMj8EBBcl+iSeMBDlY1IrtyRvWRPuif42/b88jyi/GCvOR0xsu+Fab+kxmdVcOmoLTdQkccAey+D0byL6RFVuLsKIijL/aCSVTlEIki4z7gs9FLR3VPpMhlROWNuZBWcEh7MY7RZCF8iH6/J5Nn4l3IGQpJc9VCzvgZd5WoAcJhUBPnDY0miM8Xv2zj1UtgDMZaIYl4Dx5QuXUbeWFTk21G8aocWRbydlCdv9ZH3d5VH71mJ3gUY0SCdVmRkMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjVYyH+TQbRIuxh0PqcsO9obsXJ3Pl1aJ0/Qn7aKAsM=;
 b=amCYWhwaYCd8X7lQfosF3XRY31+my1kUOvnF/tOCn99gMu2N1OejTe2DYvBVHVlxyJRvceeuEkpRg8Pc0vPOxqT1nMZfbeFS8qLfKODrGCUwaD4yujnTs1QgBwksigzfDBeCoFA1hZ1B/vOlqYxKEDop4E0rN1uMmvgPXuob/HfoO6L6RXcMGqDhSK/ZxYP0yoZgu1Vh9/KrjeaeVb1q8KtniDr+r4OxiTfy+LHwJ3IKR91AdxslxC6FYNSih2+kY2FfAE4UNBwB43eRu17OG0B0WpFEAEv0sfSm/jn+UzLmPjXekzuOUmhEygj3iKaaURuofI40klg5aURyHsBHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5534.namprd04.prod.outlook.com (2603:10b6:208:e6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 19:05:09 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 19:05:09 +0000
Subject: Re: [PATCH v2 2/3] Cygwin: path_conv::check: handle error from
 fhandler_process::exists
To: cygwin-patches@cygwin.com
References: <20200908190246.48533-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <f73dd163-6875-5f66-4b0c-4196f245bed3@cornell.edu>
Date: Tue, 8 Sep 2020 15:05:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200908190246.48533-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:610:54::32) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:fc34:902a:527a:1c90]
 (2604:6000:b407:7f00:fc34:902a:527a:1c90) by
 CH2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:610:54::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 19:05:09 +0000
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01682cda-ca94-46ee-7a28-08d8542a1b4a
X-MS-TrafficTypeDiagnostic: MN2PR04MB5534:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5534E87EB77509F4A613EFE0D8290@MN2PR04MB5534.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkcBT+2om87bgWDQ7Y4TlRaFwMyFiUc+EVn7FiIIrmrTXVM6q5F9IL/WB2RbsvDuSu07A5NMzE+Dmjm8W5GTdlfq9klSnLQetZ+rxdw9gssUiHgEbPz2+OjFlbW7tiifZpfMGqBE8NNAms2g11PNnbF4YaUa4ygj9VHfv0KCY7I/TJOaaIsVavszLnlMiTKacOB2AmHOAS/KZ9VEGAEDA5K4yHc4+aSbrj38KKm4omXGg+lyO0ZCBtFT4rzi/qd7VnGWIEC9L2NevYBKye7RhYXDxB+Qp7Qk3U8UelcXllAjv3fiRDi3+z8/aKDQeeoxvQlpya19xQHsXYgz+Pr5uaKW6NWVfsYagxOD9ptVJmPj1ckh4ZN07Kkd3wM3l/EA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(186003)(16526019)(4744005)(786003)(2616005)(316002)(66946007)(31686004)(5660300002)(66556008)(6916009)(75432002)(83380400001)(86362001)(36756003)(31696002)(66476007)(8936002)(53546011)(8676002)(52116002)(478600001)(6486002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: plLBqQ5mx/drz9mllV4LwqJVe1vTuG/4VRB2vIPVSTitKBAIYgHYDGKj2PvA8NeEG/gq/a+arHgEC/hn+i9M5eM0nynSrfialT6ZIvCLNhRoTVIXnFC7mKP0OkQyFkKRCs03e6IbiEPsb5Gzm4tgI5Fhwc5i1O2KdONv7sCksNnYHE8y36h2PZa60O1XAPQpehmyaUPly57p7JHMXp5zk909nPNR6uVb8o5hx1Ct+hJNjy3KSmr7AW1OEnpbh7IQED8AR2gX6gnWW/+XfOjC+jLTUY8OBBYRtegjW5p1blYgDKZThkhDwk6qmGXAw25qUHCwwjnn9VpfI3/EfZWZukWDiOPeplxXlEIzZ0lGDWuI+M7sz5dsGKn4e0F3BWQU96kslf9oNIzNjIQXGFmqESWTfUsVmri/Ga1ttKAAwGRFX1GkqfIqG5mU7HVAPPK7/jB3Qo82EhLEd4WYkURRysIWFLuGTL+KqbSK26euUga85Xo4+oemjddSucjcvsF5aqiIXFVMLW9hSxADQwJaJDyiCF5ZWsk+VPzIh+rVrpBnVOAJC8B/pdo9fkjbmWGjWNi2EsJP1wpBA4av0ssqiB5wRcd6EDZ+qg3YRzBOvDlYm4EL2kdfg/QRbNAKPTbPWC+RVmoTUPSYGtWlteAljvLO52GTzJDFLKmrxXSvkIDkHvXqB9VVAdI/L9rL3k9kFTL0Dswx3IECUrCTmObrYg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 01682cda-ca94-46ee-7a28-08d8542a1b4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 19:05:09.8439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufgcvDquScVd/rMX4XsdfhNzOVw6uC4rjXkENJYtlYEq6ipGYbRrowFIFLjnPcFud4OrHSw15PvJeIHHfQWX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5534
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 08 Sep 2020 19:05:11 -0000

On 9/8/2020 3:02 PM, Ken Brown via Cygwin-patches wrote:
> fhandler_process::exists is called when we are checking a path
> starting with "/proc/<pid>/fd".  If it returns virt_none and sets an
> errno, there is no need for further checking.  Just set 'error' and
> return.
> ---
>   winsup/cygwin/path.cc | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 95faf8ca7..1d0c38a20 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -809,6 +809,15 @@ path_conv::check (const char *src, unsigned opt,
>   			  delete fh;
>   			  goto retry_fs_via_processfd;
>   			}
> +		      else if (file_type == virt_none && dev == FH_PROCESSFD)
> +			{
> +			  error = get_errno ();
> +			  if (error)
> +			    {
> +			      delete fh;
> +			      return;
> +			    }
> +			}
>   		      delete fh;
>   		    }
>   		  switch (file_type)
> 

The subject should say "2/2", not "2/3".  I have a local third patch documenting 
the bug fix, which I didn't bother to send.

Ken
