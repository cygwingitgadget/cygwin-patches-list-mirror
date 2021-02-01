Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id D2D5E3860C3E
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 09:50:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D2D5E3860C3E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MALql-1lGiBg2ZB5-00BxVw for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 10:50:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D32D6A80CFE; Mon,  1 Feb 2021 10:50:54 +0100 (CET)
Date: Mon, 1 Feb 2021 10:50:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210201095054.GF375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
 <9b430aa5-1033-ebef-b002-b1523355271c@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b430aa5-1033-ebef-b002-b1523355271c@cornell.edu>
X-Provags-ID: V03:K1:iXmedrGsVWuLlBeARKOc4bU9uWn7GpiH/k5jT5XQCl/BhXGOfM7
 x6cURV7+V3ni/3GjQUWm/NN4COlRmYr32z8DKebWN0F6RMF0fSXgz/BbAvFct6v3AfmdCkR
 mnGVasIRpS4WH9gz/NSxl0jJJBEx8lx82LiQPPESjqTwxd5IBg0h5ufvUFP3jSGoklpVG6f
 WmE3Y2D07zNTe3867ZVbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7a3x2G4LNHU=:RtwxN6SHpmLN9YKBmSDaDf
 z4xOu6r7T4Nf9O5e7W5Nbrh1TE+JBLpyMmdSw0cOgqOyPD10S5qNYd7oav3weO7lJmojl/HKa
 VSXkYrwHAjeCoJTIdSI8iueBrSZPdqRQqONIhLwC1NWODpZxlqzNG/QGBFsiYJaeBR+NPE5y5
 n8PGLJkzCm8TgBAAqMiHr8SS8+HrxtMgVju5m69wOzeXZr2caiHXK+QRu8xf9Z3rorw8IPxko
 DZ0TiV5Nu+RCpK+gnrWoXtG9SHXBtXPSHVoWBOIAxPOYGySXAycTb6QRGXL6P0N2tOVT7hfgj
 IuCklI7oGy6pXJo5dqdrxiExIoPMRnscEZcuVqXF1EIpgYMTJMqKmosdK0XRANnYlNIWi9THz
 vKArw8ty2Xd4jT2+LdoaTLeWxxQIH8sjib5/CIWg+ONDpIL3vo55hWYyEehSVlwG14p0cz7rt
 ii2Q+NnmBg==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 01 Feb 2021 09:51:01 -0000

On Jan 28 15:33, Ken Brown via Cygwin-patches wrote:
> On 1/28/2021 11:07 AM, Corinna Vinschen via Cygwin-patches wrote:
> > One problem is that there are some applications in the wild which run
> > loops up to either sysconf(_SC_OPEN_MAX) or OPEN_MAX to handle open
> > descriptors.  tcsh is one of them.  It may slow done tcsh quite a bit
> > if the loop runs to 3200 now every time.
> 
> I don't use tcsh.  Is it easy to test this?

I just checked the source.  In the olden days, before the invention of
close-on-exec, tcsh closed all descriptors > 2 up to OPEN_MAX prior to
starting any executable.

With close-on-exec this happens only at startup and after an error
occured.

So testing should be easy: The tcsh startup may be noticably slower.


Corinna
