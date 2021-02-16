Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 6AD9F3854830
 for <cygwin-patches@cygwin.com>; Tue, 16 Feb 2021 11:30:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6AD9F3854830
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVJZv-1lL5Df2zpf-00SNG7 for <cygwin-patches@cygwin.com>; Tue, 16 Feb 2021
 12:30:52 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 13C3FA8093F; Tue, 16 Feb 2021 12:30:52 +0100 (CET)
Date: Tue, 16 Feb 2021 12:30:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] winsup/doc/posix.xml: add note for getrlimit,
 setrlimit, xrefs to notes
Message-ID: <YCus7LynfyqkvjWl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:oMLhraeb4wXXATerTgvf5oo/hbummcyogHM9PxTRbtS9PWRGbs/
 GvFGPOjb6oyVqjTmUdCiPjNkvzXjANY9mWZoKwa5tauRC6zUf8Evo9hzrWGSxsfCUWMKvOZ
 W/5pz9ctRiZOFzPh/yLahiqTmWVD679sHXMdI1hnlABCUlSPO5uDDxL+cn2Fu+P2wuk7m0V
 28OyLrVoegztCKl6ah7Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPGtdUzWZnU=:ScLA88P0t9jP026kqiXjJR
 B5q6vudhuB0p9nfIziBebEyKE+7lswMNRT/3qCglVHuK/6zr2RyM3YL9Dek3DwWtlIZdv8OSt
 NZGNHEHXsHJxkkGRjTM6Kxo4cXm1himebGwzTlNeHAQBwqbBIZVnkZdHyHJj04lnur/KsGQoE
 dxUwNK4IhnKK/UcLezGAHvR4eslIAS4kX2A7UxDZGvMQK3lhxwouOWGoPbm186amnYxdklhH7
 C6KyVGolkomzqb12YGs/yFzBuWl5azYY+0BnMJQhCEI+Bj17mlPsK8G8xJcjKKlbAwtHJHADJ
 5PcoZJDWMramDtFecJjonFNxh+RvT4Ah14TNTjUlg2bqnTQTYaJ1jt0bQuC0boDTZ8V5ZG2BA
 eqQrcilSSMLIR95OraKEAuYuLZv9ZEUYrNFn5rIL9/mA9cZeK2ogNtJjEGsQcWcuKOzUxpgVu
 pfy76lzJXQ==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 16 Feb 2021 11:30:58 -0000

Hi Brian,

On Feb 15 15:35, Brian Inglis wrote:
> 
> change notes to see "Implementation Notes" to xref to std-notes;
> add xref to std-notes to getrlimit, setrlimit;
> add note to document limitations of getrlimit, setrlimit resources support
> ---
>  winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 44 deletions(-)

Pushed with a change:

  <xref linkend="std-notes">(see chapter "Implementation Notes")</xref>

-->

  (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)

The reason is how xref is handled when creating html docs.  The result
of an xref is always 'the section called "..."'.  With the above change,
the text works (albeit differently) in html and info file.


Thanks,
Corinna

