Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 91BEF3851C3D
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 17:05:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 91BEF3851C3D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M8hEd-1koeIQ0tXt-004fyH for <cygwin-patches@cygwin.com>; Wed, 02 Dec 2020
 18:05:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 53CCAA80D12; Wed,  2 Dec 2020 18:05:26 +0100 (CET)
Date: Wed, 2 Dec 2020 18:05:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201202170526.GW303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <b8610713-5e7d-7b19-93f1-3ded9ca12bc6@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8610713-5e7d-7b19-93f1-3ded9ca12bc6@dronecode.org.uk>
X-Provags-ID: V03:K1:arMkBpDc/NTiRpYuofE2Vlt2WIrx7DORnJjTzuAF6tm5xzmeAgv
 1o1i/uZymQaOaaIKQEZM23NLhrp05QtfUto9w23I80CCS+zMT3D+Lcko9VBoHcfU6LzVcjj
 +N9jHB3h0s7EqJHuaJVZh3ooT+jLplE98hhGThbPqEmkrkIEkGpK7leMJ+OrnDrF0PdQHGW
 62JmQGH3Qw1Ao5125XJGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dohNdgGY5mI=:DTWYlCKT5wwUhgRAgrh+Mn
 CdAUrgpo86G0odYeT5pgYlRjaDmOheI+ouKaSp8gBZU39unMX48bj40o2qyenDv7LjIufLwVz
 VTImr7tdQLROrjRMSFrLGNjzsSNlhbOzvYNBzidD0RGs4AdQVsbYPOm9CRS/RjMNCKmeh642k
 A5wAekOS9Pf8msHMgboDH1a4aN/Q95g0NEcyPa3GWF0KJhlAjz30n8+/TYp9Ckpy1A5iCWqy+
 xo4SgA0sK/tvn9yvxqyBBWbz4rRNvYARx3F1w1k6EDm6PtDh3MMh3yhVSe5ClavC3Jlvspaj5
 Iy72wgdOru0qYpFPHqdSofI/Y8+V+LNLTA3PHJWufLCrZIUlR9F95GemmzM861v1UxFJq74sh
 eq+bLPJLz+XUweQ/i2oDH0P2Boj3EakKldkCX2phBz4D0UjoHp9pqBOt01Vyo1cKQ8HuS7clc
 Eniz+X/uVw==
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
X-List-Received-Date: Wed, 02 Dec 2020 17:05:29 -0000

On Dec  2 15:36, Jon Turney wrote:
> On 01/12/2020 09:18, Corinna Vinschen wrote:
> > 
> > What bugs me is that the mingw executables are built in utils/mingw,
> > but the object files are still in utils.  Any problem generating the
> > object files in utils/mingw, too?
> 
> Not easily.
> 
> This behaviour can be turned off by not using the 'subdir-objects' automake
> option.
> 
> But then automake warns that option is disabled (since it's going to be the
> default in future).

So why not just move the mingw source files to utils/mingw, too?


Corinna
