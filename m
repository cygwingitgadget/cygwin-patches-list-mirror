Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 330A83870883
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 09:54:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 330A83870883
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5fUy-1l7rSe3BbG-007AlL for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021
 10:54:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 41F29A80D4B; Tue, 19 Jan 2021 10:54:14 +0100 (CET)
Date: Tue, 19 Jan 2021 10:54:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 11/11] dir.cc: Try unlink_nt first
Message-ID: <20210119095414.GM59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-12-ben@wijen.net>
 <20210118121343.GZ59030@calimero.vinschen.de>
 <1e7f1329-37bc-0e83-ed03-9d7f006acdde@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e7f1329-37bc-0e83-ed03-9d7f006acdde@wijen.net>
X-Provags-ID: V03:K1:5fnJZqsf7c5FIR0E/6PP3Xlsbn3R4YCyYYxfeAPmQ365N2csuIs
 VbYsAzgHKXo/+GxeEiZkksNJYWctLoHWLw5da8joimcV2cvwVRZbTmpykuYruQM0MhEc4r0
 hzv5s84Kkjvg64GI5YWe1A+T+6qg0u+j19SmLDdPkiOLsnUcPk4kXsQA21RTx1TgYZa3BYE
 EqXHCC45l5ePLyqnATRGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7shcXf+XSoE=:kRz7rRBBzku06XJZJlVGtV
 3VioAYaEwjRZjE6UeaJBodImocxL6bdjfXrmMIccAxgL87TgHEAzZGhOsuiwYihxLMv27Yu6p
 lQeME0OAkuNfatBMG6KYCYGStImVJ8w4n84fs6EgJyHatEDq9xQwOqoMCAwjv1YWfsk9w6Kn/
 TFdtk0IZpxqHS6usf/1p/93F2/ajPFXbpoVkkI4UGeI57GzkaRQ+YA4P8cj2ALRaa6yjRDj0o
 QcROsdcZzJjFUSIS/wuE9ie4cd8UI8zlH2MGza1L6WeFMVY4x9VgalVPGAO7u3K0qw1GCJfne
 Lv+DtYX7+qJTSAqiD3a2GbL18HT+aEuLxoP0BEILPZJ8iXX0OfN88yplvXEpdg7g01Vilhahl
 mEofmeGeKULeja0dID/p03l2tO/rTKV/5dsm2UKSRANcb+wjWaUd5S7bWrX2cJgFwM4xYojZF
 GvyueR+rkg==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 19 Jan 2021 09:54:17 -0000

On Jan 18 18:07, Ben wrote:
> 
> 
> On 18-01-2021 13:13, Corinna Vinschen via Cygwin-patches wrote:
> > 
> > Your code is skipping the safety checks and the has_dot_last_component()
> > check.  The latter implements a check required by POSIX.  Skipping
> > it introduces an incompatibility, see man 2 rmdir.
> > 
> 
> Yes, I missed has_dot_last_component completely.
> 
> As for the other checks:
> dir.cc: 404: fh->error ():
> * Done in unlink_nt
> dir.cc: 409: fh->exists ():
> * Done in _unlink_nt through NtOpenFile, which will return either
>   STATUS_OBJECT_NAME_NOT_FOUND or STATUS_OBJECT_PATH_NOT_FOUND,
>   both of which resolve to ENOENT
> dir.cc: 413: isdev_dev (fh->dev ()):
> * Done in unlink_nt
> fhandler_siak_file.cc: 1842:  if (!pc.isdir ())
> * Done in _unlink_nt through NtOpenFile with flags FILE_DIRECTORY_FILE
>   and FILE_NON_DIRECTORY_FILE which will return STATUS_NOT_A_DIRECTORY
>   and STATUS_FILE_IS_A_DIRECTORY respectively.
> 
> Have I missed something else?
> 
> Also, I think it's better to have isdev_dev (fh->dev ()) return EROFS,
> which is the same as unlink.

No, isdev_dev in rmdir returns ENOTEMPTY because /dev is a merge between
a virtual and a real directory.  You can write into that directory by
adding new entries, like the symlinks for stdin/stdout, etc., but
of course it's a non-empty dir.  It's a kind of stop-gap measure so
/dev doesn't get removed accidentally.

In retrospect, checking against isdev_dev is a bit unclean here.  It
would be cleaner to add a method fhandler_dev::rmdir to override
the rmdir method of the underlying fhandler_disk_file class and handle
this in the fhandler class as desired.

I pushed a matching patch.


Corinna
