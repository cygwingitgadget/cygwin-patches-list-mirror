Return-Path: <cygwin-patches-return-3316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8008 invoked by alias); 14 Dec 2002 16:57:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7998 invoked from network); 14 Dec 2002 16:57:40 -0000
Date: Sat, 14 Dec 2002 08:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021214175737.O19104@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com> <3DF8BA7A.37C82FE5@ieee.org> <20021213133801.A17831@cygbert.vinschen.de> <3DF9F616.F1511B8D@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF9F616.F1511B8D@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00267.txt.bz2

On Fri, Dec 13, 2002 at 10:00:38AM -0500, Pierre A. Humblet wrote:
> 2002/12/13  Pierre Humblet  <pierre.humblet@ieee.org>
> 
>         * security.cc (get_user_local_groups): Use LookupAccountSid to find the
>         local equivalent of BUILTIN.

Thanks, applied.

Corinna
