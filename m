Return-Path: <cygwin-patches-return-3424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8503 invoked by alias); 19 Jan 2003 00:23:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8487 invoked from network); 19 Jan 2003 00:23:19 -0000
Message-Id: <3.0.5.32.20030118191516.00808100@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sun, 19 Jan 2003 00:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: etc_changed, passwd & group
In-Reply-To: <20030118234943.GA7895@redhat.com>
References: <3.0.5.32.20030118173700.00802580@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
 <3.0.5.32.20030118173700.00802580@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00073.txt.bz2


OK, forget what I just wrote, it won't work because the state is
reset to initializing. But the idea of calling init just once
without +/- 1 has potential. Perhaps by adding a 4th state value:
(uninitialized, initializing, reinitializing, loaded).

Pierre
