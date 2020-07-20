Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id E393B3861031
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 08:15:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E393B3861031
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MoeU5-1kd7V02cPZ-00p1yE for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020
 10:15:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 27A9EA80D14; Mon, 20 Jul 2020 10:15:27 +0200 (CEST)
Date: Mon, 20 Jul 2020 10:15:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: Use MEMORY_WORKING_SET_EX_INFORMATION in
 dumper
Message-ID: <20200720081527.GG16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
 <20200718150028.1709-6-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718150028.1709-6-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:DDSJ/4nl2e1MGUE5CJ1vD76955xKEbdVEbCUhTm+2XPCYAPYKbZ
 OaK97hQXGAJlrXr3bpuy6auHr2QHOmq/2bwXDwbpW2U69SvWOfcQqk+tqemPza2z6uJq93s
 PTb4lzDLw2QGa6Ys0vYEDteyeDHs85wxSynnFaMDoyB+jvYwKtpp042d3ZFXl3Dt7t8oYsM
 CIjJhr00R/LexOup1uOVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MfOIHD+k7+o=:+3WZiQhoxMlSs51sNTqPNe
 AgPtNlKQnP8Epo6bh+pffrz2hRYjQxuJtcWgJ96jWDBEOQ9lZGDMh4MDzeFLcRudB4+jV/uJC
 oLZjhNQRM2yW8I9p1SqcUfW+/5nP2Tag3zW3iC5t2v14gR8O8MYh4uSQbUitl2rf/DpaoGwhW
 jCK/7fiRChCLNy9ZsJPUar+VF5CmhBUZXtZZCZ5KEyleVUZnVTIgeVzIAa3u/oZCdbiglDKt2
 XAmSe1o3TdbfxmGDsS8GyE0CoxvusaejRzsrq4uJXgyOS8B5Ztvnj58xLjrJUJwYyCuV7NmUC
 gVe95Uw5dZhytGq0GI59ihqEFKw5U9311HoDClZ8P3sZIw5iZg9/Yqm2i8X3IW46/cJxZkeIt
 K1OJfqo5mfvBe7Ns+5ceOzkZDsHR2jLTe1Ba770HNftml3FDsDJUuIjmxrDFdODLVgttF0FGQ
 Cu/6A3TBnMLyYeagNKAtrMEthRAh6hYheXJFUMFitpeMZLRE3JqrKPdjqjwsmw5OKeJu3C58Z
 JzSJx1tpFefQgs2DokTE/m5GmN3HvkTi6oN9UrbvTGS0VTY4u+im8UqB/jYWkBOavaeT5d0z8
 TaN1nO8fms4gDnaVmNhQu+aoOPB/aazDd1tKnBsc5wscMHTXb9Fg4mbC/veDU5x1f5Qk95VmJ
 oQvUxotACq7+dvwOe4gHccxXQPex178oy4rkBbAMw0X1JYJRWPXjfWMIFzSn9bfZwkEIVfN2g
 Fsb/Gznt/qtLY7twr21xnIIdflUdzVMaI8Fbu0J1Nt7cXjAHj55joI7Zt35PaxQHRMdFpvPK5
 bZHDFby8PZwvZuL/3aflgtN6gQL7+QkEwWdDGEnQ6Rb0XpE2LcfTWLNtU5eXnx1l2YNctq54D
 QA/Tsgw3sZRACxZrM8Yg==
X-Spam-Status: No, score=-99.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 20 Jul 2020 08:15:30 -0000

On Jul 18 16:00, Jon Turney wrote:
> Use the (undocumented) MEMORY_WORKING_SET_EX_INFORMATION in dumper to
> determine if a MEM_IMAGE region is unsharable, and hence has been
> modified.

Great!


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
