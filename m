Return-Path: <cygwin-patches-return-4792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8271 invoked by alias); 30 May 2004 05:04:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8261 invoked from network); 30 May 2004 05:04:37 -0000
Message-Id: <3.0.5.32.20040530010121.007cd970@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 30 May 2004 05:04:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make add_item smarter
In-Reply-To: <20040530043431.GA12896@coe.bosbc.com>
References: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
 <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00144.txt.bz2

Yes, we could use tail, but then we need to add logic to preserve
the first / . I was lazy, or perhaps speed is not so important here.

Pierre
 
