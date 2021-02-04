Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 64051393D027
 for <cygwin-patches@cygwin.com>; Thu,  4 Feb 2021 19:38:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 64051393D027
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6DSi-1l19o72S2y-006gJv for <cygwin-patches@cygwin.com>; Thu, 04 Feb 2021
 20:37:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0B9E2A806FB; Thu,  4 Feb 2021 20:37:59 +0100 (CET)
Date: Thu, 4 Feb 2021 20:37:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] mount.cc: Implement poor-man's cache
Message-ID: <20210204193759.GL4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-10-ben@wijen.net>
 <20210118115103.GY59030@calimero.vinschen.de>
 <36453e31-040d-7918-f19a-2f379b988194@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36453e31-040d-7918-f19a-2f379b988194@wijen.net>
X-Provags-ID: V03:K1:vU90SC1Q12bZ9l35QZy0NtcuUlk4BrpRMU2qu0MnIhyob+ob1dD
 kUOz8LCb76n1qevebatop8rb0byGssrv+3w1vDG01+ZrokB3KZFef4oEzsqxmdHUjNdo6uC
 KZbJgQ3pvVCuT7oPV1mlQlCkljmedWlY1x4+NQON+3Gwva7sU37HJxMJhoojI+sXKk9AP5U
 qNPzbPben2s7vTy3lMMeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IOl4NLEXr9o=:LdAoMOBbYbxn6xWqBYUsPg
 UiJxihQlVfIZ3Ph/XPcgUWuVGHCA4GgF9bjJKer4lyqN58XRUEzEf7YdQgQXDq2sn1egsZUid
 0sYIGNfS55MNcEJftQytafTIGT+hocoStmcXldWYpgezpIbWGA2BfA37o4g3dvMgRAe2Q17eY
 g/RwmgRuVdWL6asqGmX1Cb9qJbXUDVNGNd5ELr8uy1BChmvQCuTkBw1BpvSW8g1IDzGKzozmm
 0//++qnLLdoPMqlXi2JBHyoI3eH7ljzRx9UkwtNuswx/kE+/3TBvPZohBMw8N2ruXPtQ0IfXV
 KFIANdDP4mwlLwaJ4J7W4NIerdd1cNMzMscyTcfAp5WD5chVNDScq26TQW4RHaq8q0o41X5tM
 fdyYchhsnL9Z/R8HE2axRzBUfzaZwfHSn6jfmINWetzM9rh3luTIk4T4YmELrbHArlIoC4sc2
 iB3jAabxMA==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 04 Feb 2021 19:38:02 -0000

On Feb  3 12:38, Ben wrote:
> 
> 
> On 18-01-2021 12:51, Corinna Vinschen via Cygwin-patches wrote:
> > Ok, so hash_prefix reduces the path to a drive letter or the UNC path
> > prefix and hashes it.  However, what about partitions mounted to a
> > subdir of, say, drive C?  In that case the hashing goes awry, because
> > you're comparing with the hash of drive C while the path is actually
> > pointing to another partition.
> > 
> How can I mount a partition as a subdir of drive C?
> For some reason I can't:
> $ mount /cygdrive/e/Temp/dummy /cygdrive/c/Temp/dummy/dummyone
> mount: /cygdrive/c/Temp/dummy/dummyone: Invalid argument

I wasn't talking about Cygwin mount points, but rather about Windows
mount points.  Since Windows 2000 a partition can be mounted into a
directory of another partition.  Only drive C: (ignoring non-harddisks)
has to be mounted with a drive letter, all others can be mounted just as
on Unix.

But, yeah, Cygwin also supports bind mounts.  Here's an example
from my /etc/fstab.d user mount file:

  //remote/cygwin-src /cygwin nfs binary 0 0
  /cygwin/pub /home/pub nfs bind 0 0


Corinna
