Return-Path: <cygwin-patches-return-3970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10959 invoked by alias); 18 Jun 2003 03:04:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10950 invoked from network); 18 Jun 2003 03:04:31 -0000
Date: Wed, 18 Jun 2003 03:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: getdomainname
Message-ID: <20030618030430.GA27002@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030617220548.00805780@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030617220548.00805780@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00197.txt.bz2

On Tue, Jun 17, 2003 at 10:05:48PM -0400, Pierre A. Humblet wrote:
>2003-06-18  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* autoload.cc (GetNetworkParams): Add.
>	* net.cc (getdomainname): Call GetNetworkParams and read the
>	DhcpDomain registry value if warranted.

Looks good.  Please check in.

Thanks,
cgf
