Return-Path: <cygwin-patches-return-2304-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23904 invoked by alias); 4 Jun 2002 16:36:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23772 invoked from network); 4 Jun 2002 16:36:53 -0000
Date: Tue, 04 Jun 2002 09:36:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <9429631277.20020604183634@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: Re[2]: [PATCH] _unlink() & rmdir() on /proc/*
In-Reply-To: <20020604153535.GA11056@redhat.com>
References: <11415277457.20020604143720@syntrex.com>
 <20020604153535.GA11056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00287.txt.bz2

They are very small:

syscalls.cc.diff and dir.cc.diff have 8 lines added.
path.cc.diff has line one changed.

Does this require an assignment ?

CF> I haven't actually read your patch since, AFAIK, you don't have an
CF> assignment with Red Hat, right?  If this is the case, would you mind
CF> sending one in?

CF> If you do have an assignment, please let me know (here in
CF> cygwin-patches) and I'll take a look at this further.
