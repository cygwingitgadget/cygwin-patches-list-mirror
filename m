Return-Path: <cygwin-patches-return-5348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26063 invoked by alias); 10 Feb 2005 15:43:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25691 invoked from network); 10 Feb 2005 15:43:26 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 10 Feb 2005 15:43:26 -0000
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1CzGQg-0002Uo-Aw
	for cygwin-patches@cygwin.com; Thu, 10 Feb 2005 16:40:30 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2005 16:40:30 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2005 16:40:30 +0100
To: cygwin-patches@cygwin.com
From: Eric Blake <ebb9@byu.net>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Date: Thu, 10 Feb 2005 15:43:00 -0000
Message-ID: <loom.20050210T160326-68@post.gmane.org>
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.44 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: gocp-cygwin-patches@m.gmane.org
X-MailScanner-To: cygwin-patches@cygwin.com
X-SW-Source: 2005-q1/txt/msg00051.txt.bz2

Corinna Vinschen <vinschen <at> redhat.com> writes:
> 
> Hey, why do you give up so quickly?  If it's not the one way, it might
> be another one.  For us unknowing folks which have no OS/2 box with
> HPFS to mount, would you mind to run the below application on your NT
> box and paste the output into the reply?  I'm curious to see the result.

If it helps, here's my quick results on a ClearCase drive m:, and a Windows 
view to a Solaris filesystem on drive u: (I think it is using NFS).

$ scan m:
rootdir: m:\
Volume Name        : <CCase>
Serial Number      : 36984713
Max Filenamelength : 255
Filesystemname     : <MVFS>
Flags:
  FILE_CASE_SENSITIVE_SEARCH  : TRUE
  FILE_CASE_PRESERVED_NAMES   : TRUE
  FILE_UNICODE_ON_DISK        : FALSE
  FILE_PERSISTENT_ACLS        : FALSE
  FILE_FILE_COMPRESSION       : FALSE
  FILE_VOLUME_QUOTAS          : FALSE
  FILE_SUPPORTS_SPARSE_FILES  : FALSE
  FILE_SUPPORTS_REPARSE_POINTS: FALSE
  FILE_SUPPORTS_REMOTE_STORAGE: FALSE
  FILE_VOLUME_IS_COMPRESSED   : FALSE
  FILE_SUPPORTS_OBJECT_IDS    : FALSE
  FILE_SUPPORTS_ENCRYPTION    : FALSE
  FILE_NAMED_STREAMS          : FALSE
  FILE_READ_ONLY_VOLUME       : FALSE
$ scan u:
rootdir: u:\
Volume Name        : <eblake>
Serial Number      : 316278793
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags:
  FILE_CASE_SENSITIVE_SEARCH  : TRUE
  FILE_CASE_PRESERVED_NAMES   : TRUE
  FILE_UNICODE_ON_DISK        : FALSE
  FILE_PERSISTENT_ACLS        : TRUE
  FILE_FILE_COMPRESSION       : FALSE
  FILE_VOLUME_QUOTAS          : FALSE
  FILE_SUPPORTS_SPARSE_FILES  : FALSE
  FILE_SUPPORTS_REPARSE_POINTS: FALSE
  FILE_SUPPORTS_REMOTE_STORAGE: FALSE
  FILE_VOLUME_IS_COMPRESSED   : FALSE
  FILE_SUPPORTS_OBJECT_IDS    : FALSE
  FILE_SUPPORTS_ENCRYPTION    : FALSE
  FILE_NAMED_STREAMS          : FALSE
  FILE_READ_ONLY_VOLUME       : FALSE


