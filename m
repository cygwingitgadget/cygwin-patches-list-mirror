Return-Path: <cygwin-patches-return-2435-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24270 invoked by alias); 15 Jun 2002 01:01:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24249 invoked from network); 15 Jun 2002 01:01:47 -0000
Date: Fri, 14 Jun 2002 18:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Reorganizing internal_getlogin() patch is in
Message-ID: <20020615010217.GA5699@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020613052709.GA17779@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020613052709.GA17779@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00418.txt.bz2

Pierre's patch + my modifications + Corinna's insights into my blunders
are now checked in.

I screwed up spawn_guts a little but cygwin seems to be working now with
both ssh and telnet.

There is a new snapshot available.

cgf
