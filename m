Return-Path: <cygwin-patches-return-3775-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28502 invoked by alias); 1 Apr 2003 17:22:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28453 invoked from network); 1 Apr 2003 17:21:59 -0000
Date: Tue, 01 Apr 2003 17:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Two minor fstat issues
Message-ID: <20030401172154.GG18138@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030331212603.007ffb50@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030331212603.007ffb50@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00002.txt.bz2

On Mon, Mar 31, 2003 at 09:26:03PM -0500, Pierre A. Humblet wrote:
> 2003-04-01  Pierre Humblet  <pierre.humblet@ieee.org>
> 	
> 	* fhandler.cc (fhandler_base::fstat): Set the uid and gid fields
> 	from the current effective ids.
> 	* fhandler_socket.cc (fhandler_socket::fstat): Keep the uid and gid set
> 	by fhandler_base::fstat.
> 	* security.cc (get_nt_attribute): Do not test wincap.has_security ().
> 	(get_nt_object_attribute): Ditto.
> 	(get_file_attribute): Add test for wincap.has_security ().
> 	(get_object_attribute): Ditto.

I've checked this in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
