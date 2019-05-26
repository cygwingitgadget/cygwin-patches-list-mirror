Return-Path: <cygwin-patches-return-9409-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121438 invoked by alias); 26 May 2019 06:49:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121424 invoked by uid 89); 26 May 2019 06:49:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=Reader, H*F:D*ca, HX-Languages-Length:633
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 26 May 2019 06:49:42 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id UmyRh1E8kldkPUmySh6SC6; Sun, 26 May 2019 00:49:41 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] cygcheck: expand common_apps list
To: cygwin-patches@cygwin.com
References: <20190523170532.64113-1-yselkowi@redhat.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <d5c6bf3c-b429-689e-2909-01c5680e12ac@SystematicSw.ab.ca>
Date: Sun, 26 May 2019 06:49:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190523170532.64113-1-yselkowi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00116.txt.bz2

To a degree, depends on installed Cygwin packages and Windows features, but I
also have in both Cygwin /{,{,usr/}s}bin and /Windows/{,System32{,/OpenSSH}/:

        {"certutil", 0},
        {"comp", 0},
        {"ftp", 0},
        {"scp", 0},
        {"sftp", 0},
        {"sftp-server", 0},
        {"shutdown", 0},
        {"ssh-add", 0},
        {"ssh-agent", 0},
        {"sshd", 0},
        {"ssh-keygen", 0},
        {"ssh-keyscan", 0},

from ls *.exe | sort in each set of dirs then join both.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
