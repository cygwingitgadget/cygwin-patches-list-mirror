Return-Path: <cygwin-patches-return-9417-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128272 invoked by alias); 27 May 2019 04:50:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128259 invoked by uid 89); 27 May 2019 04:50:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=H*f:sk:d5c6bf3, H*i:sk:d5c6bf3, H*F:D*cygwin.com
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 May 2019 04:50:14 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id D2C0EA96F1	for <cygwin-patches@cygwin.com>; Mon, 27 May 2019 04:50:09 +0000 (UTC)
Received: from ovpn-120-227.rdu2.redhat.com (ovpn-120-227.rdu2.redhat.com [10.10.120.227])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 56F8268702	for <cygwin-patches@cygwin.com>; Mon, 27 May 2019 04:50:07 +0000 (UTC)
Message-ID: <b61928129326ea776c98684346790458791dfbb4.camel@cygwin.com>
Subject: Re: [PATCH] cygcheck: expand common_apps list
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Mon, 27 May 2019 04:50:00 -0000
In-Reply-To: <d5c6bf3c-b429-689e-2909-01c5680e12ac@SystematicSw.ab.ca>
References: <20190523170532.64113-1-yselkowi@redhat.com>	 <d5c6bf3c-b429-689e-2909-01c5680e12ac@SystematicSw.ab.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00124.txt.bz2

On Sun, 2019-05-26 at 00:49 -0600, Brian Inglis wrote:
> To a degree, depends on installed Cygwin packages and Windows features, but I
> also have in both Cygwin /{,{,usr/}s}bin and /Windows/{,System32{,/OpenSSH}/:
> 
>         {"certutil", 0},
>         {"comp", 0},
>         {"ftp", 0},
>         {"scp", 0},
>         {"sftp", 0},
>         {"sftp-server", 0},
>         {"shutdown", 0},
>         {"ssh-add", 0},
>         {"ssh-agent", 0},
>         {"sshd", 0},
>         {"ssh-keygen", 0},
>         {"ssh-keyscan", 0},
> 
> from ls *.exe | sort in each set of dirs then join both.

I don't have /Windows/OpenSSH on my system.  Is it added to PATH when
present?

--
Yaakov

