Return-Path: <cygwin-patches-return-5376-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16898 invoked by alias); 10 Mar 2005 14:44:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16757 invoked from network); 10 Mar 2005 14:44:14 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 10 Mar 2005 14:44:14 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id A764913D1D4; Thu, 10 Mar 2005 09:44:14 -0500 (EST)
Date: Thu, 10 Mar 2005 14:44:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: autoload.cc: Remove unnecessary data entries from .dllname_info sections
Message-ID: <20050310144414.GC16211@gully.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0503101212001.1188@mordor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0503101212001.1188@mordor>
User-Agent: Mutt/1.5.6i
X-SW-Source: 2005-q1/txt/msg00079.txt.bz2

On Thu, Mar 10, 2005 at 12:42:46PM +0200, Pavel Tsekov wrote:
>I've been looking at the contents of the cygwin1.dll image in the last
>few days and I've noticed that the sections named .dllname_info contain
>a lot of duplicate entries - one for each autoloaded function from a given
>dll. Although it doesn't hurt to have it, this information is not really
>neccassary for the autoload functionality - autoload only needs one entry
>per dll in .dllname_info.

Thanks for the patch but I'd prefer keeping the current functionality which
makes the use of LoadDllprime optional.

I've checked in a fix for this so that only one .*_info block is loaded
for any given DLL.

cgf
