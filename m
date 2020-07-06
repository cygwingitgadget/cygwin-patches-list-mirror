Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id DA4B53858D37
 for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2020 19:50:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA4B53858D37
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N63i4-1kyiio0vbU-016Ooj for <cygwin-patches@cygwin.com>; Mon, 06 Jul 2020
 21:50:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 69AC8A8087B; Mon,  6 Jul 2020 21:50:41 +0200 (CEST)
Date: Mon, 6 Jul 2020 21:50:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Cygwin 3.1.6
Message-ID: <20200706195041.GI514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Provags-ID: V03:K1:6flgv8p6TpGbt0ZukXC0eosCEs1AilCQuaIDuF+0otzfTtHVp6s
 sJwIpOM+oG+8jDxSozqLzXiL5wvGgLMtHEBhtBKrx72U4Kicj46dyudZ1XubdV7qC1k5S6i
 XvSr71pSdeZVEvVT4FzvoBD6iO2aHRGVEUE9bGjxSyjRIPYlyvcVyhzwGyaZJW1fQ8dqAyt
 BZM55/tsppH8VFSZF+XoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i60PB3MlPL4=:/riS9Ih3AREYvnMAWOliji
 /VBpkoo4DHcAtO+53ibhym5xJ3HC9t/DCFq+0W53a1/x+ahBSMuxstnR9taFCkSFAW8G3c8Yn
 W24g3RInUmGX7SyNi4fTUCmD7z14TGvXpDcsXdDf5oE6LMXMBxMoB+F1iIWO5XNXUKSDBrOVP
 K2xljVNtEJzLSamiWd0nmVOFMtCxlK94GCTBhqEmm1qu85Rur7pVVz8Vic68uHlUrmLOZXgMP
 BybSzmaSXDPDHG0DveY7zMGDn1l1LFKpSET+Rvye4GEEVCJ0Qs2BiX6+YycryUTG++7nhNc1c
 N5q0J8jcnLUDcJ4+EcZAuFh17qOGWn4GaZsvDl3AfL/yrCwa4jVmInHGNRSfEHBwZm1yZy1e2
 KkXEuxZcir3yTAXzpCz9ZHsZ/EHfy8UPjXpav7SHpH0mfswIVVOLe8CI9BZCD8osJJeHxTyIO
 7JE7EUcpCdTNEjHjPGsMkvIckfCAaYEwbh72E461yizH8KM2P7Fnza8BKohiMcYgO2NvCekDJ
 zaZRavZrCRKKRxHThckxJ59pBHEvCGIQEs0X5XZEDkwKxTYxuRPXWVEeL/qltT3RKwkdQDsdW
 bdsgAOzsJ8FKt1yi1gYS9YEUDM+ZVzt3lRnSUtDOOVNrauxK4UTZWN9hyzgImuLr/DX+Qefhg
 MopUv10531OP2WPqDJZB/XRmXF/omJpHEKYbb34VjCiaXl7IDJOdXb443gIANuc/AvIOS98N4
 833vLxaG/M967IhUAAvsrgg5ZnpYS+g04NpMrVej6C+0LHKfXCMQfLel7ZpJCG/sbKKEfMyHG
 L/fQ1x2hwgZMdU2Jgqc0dJpSK4vWg93XA7fFTLgw7xsmvSZMwWZWJq6rdfUf8zweTPWC90yCK
 /f2PKs+cOLiSF36sZUDQ==
X-Spam-Status: No, score=-97.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 06 Jul 2020 19:50:45 -0000

Hi guys,

Do you have anything in the loop which should go into 3.1.6?

Given https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=bb96bd0,
I'd like to release 3.1.6 this week.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
