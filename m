Return-Path: <cygwin-patches-return-3802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29774 invoked by alias); 10 Apr 2003 03:40:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29762 invoked from network); 10 Apr 2003 03:40:32 -0000
Date: Thu, 10 Apr 2003 03:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: security.cc
Message-ID: <20030410034053.GB16622@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030409232437.007fa540@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030409232437.007fa540@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00029.txt.bz2

On Wed, Apr 09, 2003 at 11:24:37PM -0400, Pierre A. Humblet wrote:
>Please double check the removal of "else if (pc->issocket ())"
>from fstat_helper. I think that case has already been handled before.

FWIW, I think you're right.

cgf
