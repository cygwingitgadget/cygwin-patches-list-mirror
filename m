Return-Path: <cygwin-patches-return-8281-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100143 invoked by alias); 1 Dec 2015 14:50:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100126 invoked by uid 89); 1 Dec 2015 14:50:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.19) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 01 Dec 2015 14:50:50 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M4Gyx-1aLZvo1SxH-00rpKZ for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2015 15:50:47 +0100
Date: Tue, 01 Dec 2015 14:50:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Introduce the 'usertemp' filesystem type
In-Reply-To: <20151201142725.GY2755@calimero.vinschen.de>
Message-ID: <alpine.DEB.1.00.1512011550290.1686@s15462909.onlinehome-server.info>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de> <20151201142725.GY2755@calimero.vinschen.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:BA836++FEsg=:93rIkYxNb44edHyEtsRuv7 HhiGNjH9jdT3Iz6DGgm3P25s3cm8+k3aKocM6+yHz21NiPzzVrulUBS6WP9adq0G/BC1kdv23 n5x77LfMfLzDnnNZzSrXwdHmHV4wKoJpe38jYv91QmrHt4wdBFX6teNg+xvB7v43qCG1dkLQ9 7T+YbELfWUNJBFkK7VdMRnlF/wJs+rUnUfRmh4UmPa43E+ZMZp8bA9dRiOLCLOv1K4CbzZzdz Xt16dmOfO4WwQxVdBRZZuawVyLemsgYkl0xDAUT76OuNagDDVnfxF5Zuj82LhTx6B6rDXHFFK DhMSjfXhJS0bx6k16CsgqEE1d8bf6VsLaOMjSBC6yKgCX4cMVNQbYo8RNuIxD69fXWQV6z+ED qwH0zwMtUDRAPhDKyB1m39gsM64rPWt1armUEnbaHQ7kNr9mfnLYrULM8i32Mi0SgwLgLGxrj 2e2fzPJysSV8k/BnxCNSFixRERV9Png9O3MrazzdXYzoZR1RxxaRfunS7GY1dmn3sTq5sVaoz Olx3AtXLyVdBGQs/32BpL0bhGL3uaJXn+GScvhzhsft3w71otUDUzx2zQaphF9gPRewhQv4j3 5UojMYJAyoOFyxhiFCDX01r7OWNSYBkWr0tr7lBftGsHrNHSIivjBCancjaEBkTtmahUR293B 7o2ii/OfBVMff86jMdfqxH/hSZuT/5mOLfzk6YR5CCNH5pTURFRjB4ZdI+gusmfqirZwUhKLB jff9efEKKPJ0Idt7GlXg6vCk9Z24GEATBGaA7yAzuHmVPX+8/2Jquii2Yjge+iRIh1XdkfEu6 WYaH+c2
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00034.txt.bz2

Hi Corinna,

On Tue, 1 Dec 2015, Corinna Vinschen wrote:

> On Dec  1 15:02, Johannes Schindelin wrote:
> > 	* mount.cc (mount_info::from_fstab_line): support mounting the
> > 	current user's temp folder as /tmp/. This is particularly
> > 	useful a feature when Cygwin's own files are write-protected.
> > 
> > 	* pathnames.xml: document the new usertemp file system type
> 
> patch looks good.  We just have to wait for the ok in terms of the
> copyright assignment.  Might take a day or two.

Sure thing. Thank you for your patience!

Ciao,
Johannes
