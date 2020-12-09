Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 72E313842433
 for <cygwin-patches@cygwin.com>; Wed,  9 Dec 2020 09:25:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 72E313842433
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLRDv-1kWEDc2khn-00ITxs for <cygwin-patches@cygwin.com>; Wed, 09 Dec 2020
 10:25:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EF630A80759; Wed,  9 Dec 2020 10:25:26 +0100 (CET)
Date: Wed, 9 Dec 2020 10:25:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <20201209092526.GO5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
 <20201204121043.GB5295@calimero.vinschen.de>
 <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
 <20201207094317.GI5295@calimero.vinschen.de>
 <26ef013a-d3ff-7389-c022-1b10568faf79@dronecode.org.uk>
 <alpine.BSO.2.21.2012081142000.9707@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2012081142000.9707@resin.csoft.net>
X-Provags-ID: V03:K1:Noc2MPFva53rBjevT3CLRAVrs3zKHMcAwy1WQjdj6CFk8Rm9uRu
 acNVQTiSEktiR+Nhe2w2AdeERVqflH2GZLgNGVB3Y8xR7lZkXPZr8nGOki0yC3LrrBfaFXi
 oK39OBq7Rhidf7jT3raypDgOpebKj5FECV8hn5Fd3zcOi268Cr7CHGXMvYosOf9Nk45dTxX
 2E1czWUt9dlu7GCEmtn4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BlSA0dD/Pys=:sNku4ap0OI71n9RgbU0iU6
 ANlaEYgtQVzNsR0HmFTCIn9xlRytrZ/Bj9HAWVlXE2511gxlITza+b6h65BOj7McFMNfs0oQy
 /iTNjHKdYrKROdWysoF9f8jU+mW+S6HJiqsuJ9ftnCJBDmMv+8MjE+KonyLhW798+wc/LGKnT
 TPLjBkd7pJDNFWaC0fW2NXYGgygDS5vkJWDLk0u/cF6TIKvPmKn2UlUlJj46+x+o4p3jiaee4
 nHpSy/31YVfhlP1e5/Hpy84+ouvFmZ/TsMrUbLfj8+bm7sqslecy2HD9J8HPUEye76hKeYVbu
 UwrRWKR1Gp+uKBCmbdIs8RP0E1gi0kLIP2WO5kbUsb8WwmsOdEf/2sIqWmhGHtuismU0Utxt4
 rYGXkwvQUTICQzPX8KDdGM99Zz8u4RzSVmWYlf0ACSxnkHmSPXc1j1s1ixzggziIMX6TODwga
 et4+r2vkpw==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 09 Dec 2020 09:25:31 -0000

On Dec  8 11:58, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 8 Dec 2020, Jon Turney wrote:
> > On 07/12/2020 09:43, Corinna Vinschen wrote:
> > > On Dec  4 10:35, Jeremy Drake via Cygwin-patches wrote:
> > > > On Fri, 4 Dec 2020, Corinna Vinschen via Cygwin-patches wrote:
> > > >
> > > > > I'm not happy about a new CYGWIN option.
> > > > >
> > > > > Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
> > > > > for all non-Cygwin processes by default instead?
> >
> > I agree.
> >
> > Cygwin calls SetErrorMode(), so we need to use this flag to prevent that
> > non-default behaviour being inherited by processes started with
> > CreateProcess().
> >
> 
> In that case, here's my initial, much simpler patch
> [...]
> -      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
> +      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT
> +	      | CREATE_DEFAULT_ERROR_MODE;
> [...]

Thanks, but the flag should only be added when starting a non-cygwin
process.  Checking against real_path.iscygexec() will do the job.
Can you please resend this as a standard git format-patch'ed mail?


Thanks,
Corinna
