Return-Path: <cygwin-patches-return-3099-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32339 invoked by alias); 2 Nov 2002 04:02:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32314 invoked from network); 2 Nov 2002 04:02:31 -0000
Date: Fri, 01 Nov 2002 20:02:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Removing winsup/w32sdk
Message-ID: <20021102040417.GA17431@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00050.txt.bz2

I've physically removed the winsup/w32sdk directory from the winsup CVS
repository.  AFAICT, it was created with no discussion and it is empty.

If it really needs to exist, it should live in w32api.

FYI,
cgf
