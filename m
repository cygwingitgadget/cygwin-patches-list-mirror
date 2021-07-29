Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id C24D53858038
 for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021 10:40:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C24D53858038
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mt6wz-1n2GTc0n4D-00tR1j for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021
 12:40:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AC746A80DDF; Thu, 29 Jul 2021 12:40:04 +0200 (CEST)
Date: Thu, 29 Jul 2021 12:40:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add more winsymlinks values
Message-ID: <YQKFhJE6jhPy5xCD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
 <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
 <YPl+7gROlATG/ggs@calimero.vinschen.de>
 <8c228092-1699-35aa-7558-106f49fde87f@dronecode.org.uk>
 <YQKBmcZgFygx7cDK@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQKBmcZgFygx7cDK@calimero.vinschen.de>
X-Provags-ID: V03:K1:j+M6OrwVfJJBt9bB7zBqLJllIiStdw/u0OXTG0Qt8FCZoFHaHap
 3+euE8A8or1ys8eHQy8vLLxnU5CXYjRJdgAmqMJ5mSQS+JO8ZByFweTZ9PfUpED0X7Qp2PQ
 CpYMEVrCkPL17zRg33KNkUjBNZaHAnw6zidjhAd/bJb7Rwbu5DAXXnzpg1F5M3zRKfZS7eg
 02zyI49bU+YtPbyeOXyOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u7pbXd/U1/8=:MHZEQg0tB63+6gmt/9XAv6
 v3l9RLZFP5AEhF+OllBnHjiQ7pd+gykw4GGQQsZX9MatucNJClwWN29Jlu6N/rwQcaT1V4Bw+
 YUN8hfxHPf4VH62bhF9mzVInXZtf61ke//GlLu1A3Mo73LsPb2kIquXQuVB21VlNiHuvVNVcu
 E/4QkgaEiQzxjVWaQfKCLhJ6gfuU2V0vZfc3birrjVJUbJkC5SSbDQaS8T0wucdbEAJxbGtMg
 SuhLbao1JW8wEroaVWl+9g9HPEQ3209KpMQ/QNCuCE+WohPqUwa2vbr8pOkxzCev6wqYXqFfx
 Yt4j89y0z5G/K1slgXE6MZkhQ/k/WjTw90vSLts56hmHwiWSQEBlcgjBibk3Pz/XiYSkSkCbq
 cq2Q0xiiKgnZeZoAk++m0etN9h+KQlA65fOLSOhSPQ8w8f9FpUN32oB5EkPMho8PHME2CoV4d
 6wJb3O+eJt4Vxps5JmXXFGS1yZ0ASCA6BKOCWfLKi1o6K8GzR4HWXLccDc45J216Sp3D5gzi5
 s0UJ55O1T6KQUQVM4t4vZwu949+8okGNqUPGE0PjiEilfNu/BNSu9sKnwZDa46wyGMS6MIPR8
 mipIF8Pqz7vj+N42TjkQXVgsq5hED3DoBqMKoVQiDd7vsXGHcVYnLyjZNvctqOC2ObyQBcFfE
 ZYFBTQJ9HYwuBRjed6QMZENGfAuS3xfgRDw6NR+Ys2g9MSOl0hYVZONAdnfMBV7/DN3Hzvpse
 CTR8gGwt64+QnFH8P+kXswt7OE+sgiIWY6OTResIIp7R1+adKTL6zTlPoMT5X680siC0OESsZ
 tHjAcSWcQF1PFs5yo0O90RRe6EXK8MxRDfnJdFzs5pQ1djNVvGVSRHLXjNWX9yWK+Yj5+lBUu
 tPQKXgjlnt4AjNdWjcqg==
X-Spam-Status: No, score=-100.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 29 Jul 2021 10:40:08 -0000

On Jul 29 12:23, Corinna Vinschen wrote:
> On Jul 28 20:55, Jon Turney wrote:
> > On 22/07/2021 15:21, Corinna Vinschen wrote:
> > > On Jul 22 14:53, Jon Turney wrote:
> > > > [1] https://cygwin.com/pipermail/cygwin/2020-August/245994.html
> > > 
> > > Did nobody ask the Docker guys why they fail to support perfectly
> > > valid reparse points?
> > 
> > It seems so e.g. [1]. The answer isn't much beyond "yes, that doesn't work",
> > though.
> > 
> > [1] https://github.com/moby/moby/issues/41058#issuecomment-692968944
> 
> D'oh!
> 
> > > > I haven't yet looked at adding 'native' symlink support to setup itself, but
> > > > it's probably going to be a bit of a pain.
> > > 
> > > That may be not a bad idea after all.  Setup typically runs as elevated
> > > process, so it has the required permissions to create native symlinks.
> > > Scripts could then run with CYGWIN=winsymlinks:native by default.
> > > 
> > > As long as nobody has the hare-brained idea to move a Cygwin distro
> > > manually, native symlinks should be just as well as Cygwin symlinks.
> > 
> > I'm pretty reluctant to add this to setup in any form which isn't initially
> > "keep doing what we currently do, unless you explicitly ask for symlinks to
> > be made a different way".  (especially since when we changed what we were
> > doing in Cygwin 3.1.5, it opened this whole can of worms)
> > 
> > So I don't think that gets us any further forward if setup doesn't have
> > useful control over the kinds of symlinks made by post-install scripts.
> 
> Ok, then, by all means, lets' add a few options to the CYGWIN=winsymlinks
> setting.  Just s/WSYM_magic/WSYM_sysfile/.

Also winsymlinks:sys or winsymlinks:sysfile

Thanks,
Corinna
