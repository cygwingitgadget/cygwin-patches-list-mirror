Return-Path: <cygwin-patches-return-5200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30257 invoked by alias); 14 Dec 2004 11:52:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30214 invoked from network); 14 Dec 2004 11:52:09 -0000
Received: from unknown (HELO smartmx-06.inode.at) (213.229.60.38)
  by sourceware.org with SMTP; 14 Dec 2004 11:52:09 -0000
Received: from [62.99.252.218] (port=61307 helo=[192.168.0.2])
	by smartmx-06.inode.at with esmtp (Exim 4.34)
	id 1CeBDs-0006aN-T7
	for cygwin-patches@cygwin.com; Tue, 14 Dec 2004 12:52:09 +0100
Message-ID: <41BED3E3.1060108@x-ray.at>
Date: Tue, 14 Dec 2004 11:52:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a4) Gecko/20040927
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Fwd: [que_andrewBOOHyahoo.com: FOLLOWUP: 1.5.12: problems without
 registry keys]]
References: <20041213182127.GB22056@cygbert.vinschen.de> <41BDE01E.3DD3C6CF@phumblet.no-ip.org> <20041213185957.GD27477@trixie.casa.cgf.cx>
In-Reply-To: <20041213185957.GD27477@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00201.txt.bz2

Christopher Faylor schrieb:
> On Mon, Dec 13, 2004 at 01:31:58PM -0500, Pierre A. Humblet wrote:
> 
>>Corinna Vinschen wrote:
>>>Is that ok to apply or is there any good reason not to release the muto
>>>when get_drive() has finished?  I can't see any, FWIW.
>>
>>Oops, please apply ASAP of course.
> 
> Sounds like I should release 1.5.13 soon.

With the new process code? Is the exit status problem already solved?
Haven't tested that.

Pierre's unlink patch is also not integrated yet. Works fine for me.
-- 
Reini Urban
