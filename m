Return-Path: <cygwin-patches-return-2306-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12689 invoked by alias); 5 Jun 2002 09:15:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12659 invoked from network); 5 Jun 2002 09:15:55 -0000
Date: Wed, 05 Jun 2002 02:15:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <124257812.20020605111540@syntrex.com>
To: Pavel Tsekov <ptsekov@syntrex.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] path_conv::check - Do not check if a directory is executable
In-Reply-To: <415287753.20020604115051@syntrex.com>
References: <415287753.20020604115051@syntrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00289.txt.bz2

I see that this patch is no longer required. The snapshot from July
4th includes a similiar change.

PT> 2002-06-04  Pavel Tsekov  <ptsekov@gmx.net>

PT>             * path.cc (path_conv::check): Do not check a directory
PT>             path against a known list of executable file extensions.
