Return-Path: <cygwin-patches-return-4790-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28980 invoked by alias); 30 May 2004 04:51:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28970 invoked from network); 30 May 2004 04:51:28 -0000
Message-Id: <3.0.5.32.20040530004813.00812b90@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 30 May 2004 04:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make add_item smarter
In-Reply-To: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00142.txt.bz2

Yes, we need to remove the final slash, it can be present at the
output of normalize_path

 150  761725 [main] mount 671605 mount_info::add_item: c:/gggg/[c:\gggg\],
/hagfsfd/[/hagfsfd/], 0xA

Pierre

