Return-Path: <cygwin-patches-return-3984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32698 invoked by alias); 2 Jul 2003 10:47:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32678 invoked from network); 2 Jul 2003 10:47:08 -0000
Date: Wed, 02 Jul 2003 10:47:00 -0000
From: Elfyn McBratney <elfyn@cygwin.com>
X-X-Sender: elfyn@ellixia
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: killall utility
Message-ID: <Pine.CYG.4.55.0307021143080.2156@ellixia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00000.txt.bz2

Hi,

I have written a killall utility based on the code already in utils/kill.cc .
Would this make a worthy addition to Cygwin? If so, there's a bit of code
duplication, so maybe moving the generic code into a file called `sigutil.cc' or
something would be sufficient, having kill{,all}.exe depending on `sigutil.o'.

Any ideas bofore I submit a patch?

Elfyn
-- 
