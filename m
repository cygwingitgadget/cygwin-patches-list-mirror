Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id D7BBB3858C39
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 08:58:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D7BBB3858C39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpCz1-1mR6MW2TYV-00qjFX for <cygwin-patches@cygwin.com>; Thu, 03 Feb 2022
 09:58:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 247ACA808FF; Thu,  3 Feb 2022 09:58:19 +0100 (CET)
Date: Thu, 3 Feb 2022 09:58:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix UNC path handling for SMB3 mounted to
 a drive.
Message-ID: <YfuZK5lTopYPSwwZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:6+gT3lJ8yRwdhIjZoU3FPHWW0jNgQ8XnKvpf/KIqqR9HiYqPiwo
 CRy2HRYKLktf69ICfoCdy3Zn2ZIeX+Rl1WZPIpZvqROjebnD+dln87wEUwM5ftom5Yjw2aJ
 eX8duCPkVS9eurNpmbRzea+rtRsVGdxrYSgaIkGxf74Kfj8WjAcyAfVf+4k2DrdamGCUTB2
 BiCysbmcEsVqWdOsLKRrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wbv/pRwK6vI=:ZRMehZDFupoCsUMH5YSzfT
 zULDlO1gOOAhKlVXnCQMfL3ltxcfMRZkLuN0o5f/kmA18qqOGM7yz9XEtKOk3ipPLPDD4Uoe5
 pSY7RZ9ValTr8O+4lTiEwDk0veFBpRbAhcb4+lQnf6JAFE28q/AsppKyxBktcOIOiUp7toSpP
 19CVzSkC6dOee2CCMuGlDOxtbzAekMxiJMpwOolRNeyjSQabFZ4mYoruK/pqXFMQNIdHmXy14
 efzxV8OSRXU1i0DgRLSIwIp4u9/GDUHJy9a2gMvT9gjlMZEscBv7AjOjgQ6pAOVZ3uQCrWt47
 Lx+teVseNQ6sWg18UJRqW6cVihtDpAmQ6fCG4sE/sueJf1c/EAWJ2mnjXJFzglnOBbG+FgflC
 TI+GfsLoAUlRh5AQZkVd3fWfm+gSSzGOatvpTNu8gC/QBRKa4SUhGa6+TjLfXoOVz0RACbmGr
 pUbOVBozcSqF0Fi5oZn8oP2qxItq+b3Kr8rdolTtJA7aFw3IUvpRNtYwTzf3LAKcrj9MNbcz3
 BSYh/6mKMFOFB5gbIu1G4Zh7ehmqRZBDTyTKM+W0zbP5H/ZaLc16MnSMHVvPmB+du/Bg94ntq
 4Odcze18HEf6InO5wZVXU+p+TYImGCJBYnY7C3R1uZo2cuOZ5Ye7KaH5n+0u4oRoWGY0rKHmS
 MPwB9etpcJyV1A42DPV+SqkYbF68ryzYkTHC6ZK11oGOtb78WO6CcU72y4T4cnonbkGVDDsAf
 DqGRoFZg72n15Xv5
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 03 Feb 2022 08:58:22 -0000

On Feb  3 17:40, Takashi Yano wrote:
> - If an UNC path is mounted to a drive using SMB3.11, accessing to
>   the drive fails with error "Too many levels of symbolic links."
>   This patch fixes the issue.

LGTM, please push.

I'm curious.  I'm using Samba as well and never saw this problem.
Can you describe how to reproduce?


Thanks,
Corinna
