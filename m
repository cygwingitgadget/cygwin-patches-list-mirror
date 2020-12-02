Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id CF78A3851C3D
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 17:00:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CF78A3851C3D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McXs5-1kBzgY0ti9-00d2Br for <cygwin-patches@cygwin.com>; Wed, 02 Dec 2020
 18:00:23 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7D5BFA80D26; Wed,  2 Dec 2020 18:00:22 +0100 (CET)
Date: Wed, 2 Dec 2020 18:00:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201202170022.GV303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <20201201100738.GL303847@calimero.vinschen.de>
 <2c351d5e-3c89-3335-9dc2-89a230b57209@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c351d5e-3c89-3335-9dc2-89a230b57209@dronecode.org.uk>
X-Provags-ID: V03:K1:Os6jcGt/MndkRL8h3oEU2yGdgMD/EYO75fuJxdiqqVuph1XGL83
 /SEOCwqvlq2HQc0mA9Sxatnlo+CVRuG0G+nM5aQjSl9ewEsH4V4vKG7rkN0CohLxoKLlT0t
 PphVy1z9XOyiGCKDON5MdWtjmuaWGe5nlQCE+JxzxikZoa+9tZjneszK3AQBdcYi6vr/Ewk
 m7dhi03sDYn/M7aK0FPGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8qFDkgQbWo=:08dIOeBsXAX4OEWsJlURs5
 +WTJ5j+D8//Eto3zV8zRgUWGPcbDs+tjqEkMBmYy6TV3Dnne7Yr+dN6OmYdw7rA0iITSxSljd
 ze5qpX4OVAPgq3T70KZC4hWryw8mMdXY+jDEKg/N4jeN118NDWB9hLGJSKWgQl06p8dWz7hLB
 Qr7fkBOdZLdP5vlcSkhTRx3CMWcd/AzkX4hG6cUz03wmrzAorWOfvktNnOJ7oaGMKdFO/fkNv
 BwiPQQjgqiXmIORAwNcLaBM8tD/RLJ4pU/w2WTLj85FUyse113V5bBOJ0jYBQPMiAXtDsgfgJ
 9E8unfZ6tFXnTvSRpktiuzMu1F/CdT99DTeGWTTi148cGp4OmeYUGGZNRbgqVmuBPjwns9E+K
 vBycvqZPhrfdjtBPuGRwJJc8rvBjb/AEmbNx6DWU/lkEV8DWH+2kZFrM6NFIj4yqjASM38vVk
 DRMb2xTewA==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 02 Dec 2020 17:00:26 -0000

On Dec  2 16:08, Jon Turney wrote:
> On 01/12/2020 10:07, Corinna Vinschen wrote:
> > 
> > I also don't like how test-driver is generated in the toplevel
> > source dir.  It should either be generated in source level winsup,
> 
> I assume the placement of this file is controlled by AC_CONFIG_AUX_DIR.
> 
> > if it's a file to be added to the repo (like aclocal.m4, etc), or,
> > if generated at runtime evey time, it should go into the build dir,
> > me thinks.
> 
> I'm using automake 1.11.6, to match the version used by newlib, which
> doesn't seem to generate this file.

Ok.  I noticed the file is in binutils/gdb toplevel as well, so never
mind that.


Corinna
