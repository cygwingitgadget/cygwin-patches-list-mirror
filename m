Return-Path: <cygwin-patches-return-5260-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4758 invoked by alias); 20 Dec 2004 15:58:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4679 invoked from network); 20 Dec 2004 15:58:22 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 20 Dec 2004 15:58:22 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I91319-0000KG-JY
	for cygwin-patches@cygwin.com; Mon, 20 Dec 2004 10:58:21 -0500
Message-ID: <41C6F69D.12BC23F3@phumblet.no-ip.org>
Date: Mon, 20 Dec 2004 15:58:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx> <41C6F57E.2D058229@phumblet.no-ip.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00261.txt.bz2

"Pierre A. Humblet" wrote:
> We should also strip win32_cwd there because it will be used
> to build an absolute path in normalize_win32_path.

Scratch that, sorry. win32_cwd is already stripped.

Pierre
