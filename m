Return-Path: <cygwin-patches-return-4172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8388 invoked by alias); 7 Sep 2003 04:53:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8378 invoked from network); 7 Sep 2003 04:53:49 -0000
Date: Sun, 07 Sep 2003 04:53:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH PENDING] Have cygcheck use libz routines rather than gzip program
Message-ID: <20030907045349.GA23180@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00188.txt.bz2

As mentioned in the cygwin mailing list, I've made some minor
modifications to dump_setup.cc to avoid the use of gzip when
decompressing.  This also required the usual kludge in configuration
since it means searching outside of the cygwin build tree for the
appropriate library.

The difference in speed is quite noticeable.

I won't check these in until/if there is a mingw libz package but
my psychic powers tell me that this may be happening soon...

I just wanted to give a heads up so that no one else would bother
trying to get this working.

cgf
