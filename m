Return-Path: <cygwin-patches-return-3804-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20087 invoked by alias); 11 Apr 2003 09:38:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20018 invoked from network); 11 Apr 2003 09:38:17 -0000
Date: Fri, 11 Apr 2003 09:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: security.cc
Message-ID: <20030411093815.GB1928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030409232437.007fa540@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030409232437.007fa540@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00031.txt.bz2

On Wed, Apr 09, 2003 at 11:24:37PM -0400, Pierre A. Humblet wrote:
> 2003-04-10  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* security.cc (get_info_from_sd): New function.
> 	(get_nt_attribute): Only call read_sd and get_info_from_sd.
> 	Return void.
> 	(get_file_attribute): Move sd error handling to get_info_from_sd.
> 	and symlink handling to fhandler_disk_file::fstat_helper.
> 	(get_nt_object_attribute): Only call read_sd and get_info_from_sd.
> 	Return void.
> 	(get_object_attribute): Remove symlink handling and simply return -1
> 	when ntsec is off.
> 	* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): For symlinks
> 	set the attribute, call get_file_attribute to get the ids and return. 
> 	In the normal case call get_file_attribute with the addresses of the buffer
> 	ids and do not recheck if the file is a socket.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
