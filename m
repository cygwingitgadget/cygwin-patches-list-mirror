Return-Path: <cygwin-patches-return-5403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29462 invoked by alias); 31 Mar 2005 01:21:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29320 invoked from network); 31 Mar 2005 01:21:40 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 31 Mar 2005 01:21:40 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4094213C84F; Wed, 30 Mar 2005 20:21:40 -0500 (EST)
Date: Thu, 31 Mar 2005 01:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
Message-ID: <20050331012140.GA19459@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de> <4249A3F0.6020007@gawab.com> <20050329203032.GB32369@trixie.casa.cgf.cx> <4249E5D0.1000201@gawab.com> <20050330054609.GD2969@trixie.casa.cgf.cx> <424B31F2.4010508@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B31F2.4010508@gawab.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00106.txt.bz2

On Wed, Mar 30, 2005 at 06:10:42PM -0500, Nicholas Wourms wrote:
>As I noted previously, I thought it could be a source of confusion
>since this behaviour is not documented and is not widely know.

?: *is* a documented gcc extension.

>I, myself, had to rummage through the GCC source code to be absolutely
>certain what the implict behavior was.

Wow.  Rummaging through the source.  Incredible.

"info gcc" is your friend.

No.  We're not going to change the use of ?:.
