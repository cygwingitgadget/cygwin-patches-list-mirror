Return-Path: <cygwin-patches-return-5369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1858 invoked by alias); 6 Mar 2005 21:29:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1844 invoked from network); 6 Mar 2005 21:29:32 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 Mar 2005 21:29:32 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 6BB091B55F; Sun,  6 Mar 2005 16:30:04 -0500 (EST)
Date: Sun, 06 Mar 2005 21:29:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Use the user supplied cygdrive prefix
Message-ID: <20050306213004.GA28732@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0503062225170.1264@mordor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0503062225170.1264@mordor>
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q1/txt/msg00072.txt.bz2

On Sun, Mar 06, 2005 at 10:51:56PM +0200, Pavel Tsekov wrote:
>2005-03-06  Pavel Tsekov  <ptsekov@gmx.net>
>
>	* path.cc (mount_info::read_cygdrive_info_from_registry):
>	Use the user prefix if it exists.

>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.351
>diff -u -p -r1.351 path.cc
>--- path.cc	6 Mar 2005 20:15:07 -0000	1.351
>+++ path.cc	6 Mar 2005 20:51:24 -0000
>@@ -1956,6 +1956,7 @@ mount_info::read_cygdrive_info_from_regi
> 	cygdrive_flags |= MOUNT_SYSTEM;
>       slashify (cygdrive, cygdrive, 1);
>       cygdrive_len = strlen (cygdrive);
>+      break;
>     }
> }

Applied.  Thanks.

cgf
