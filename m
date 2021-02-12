Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 2134D3857809
 for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021 10:15:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2134D3857809
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 11CAFIPs059652
 for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021 02:15:18 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdudK5lN; Fri Feb 12 02:15:13 2021
Subject: Re: [PATCH v2] Cygwin: Have tmpfile(3) use O_TMPFILE
To: cygwin-patches@cygwin.com
References: <20210211065306.457-1-mark@maxrnd.com>
 <20210212092023.GH4251@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <a9cb0100-f5de-7550-9172-c1d75eec79f8@maxrnd.com>
Date: Fri, 12 Feb 2021 02:15:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20210212092023.GH4251@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 12 Feb 2021 10:15:23 -0000

Corinna Vinschen via Cygwin-patches wrote:
[...]
> The patch was missing the EXPORT_ALIAS for tmpfile64, as outlined in
> https://cygwin.com/pipermail/cygwin-developers/2021-February/012039.html
> I added this to the patch and pushed it.

Oof, I missed that on the v2 patch.  Thanks for catching it!

..mark
