Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 05318385828A
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2022 15:45:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 05318385828A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpUQk-1pTpEs05F6-00pvD4 for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2022
 17:45:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F01A7A80706; Tue, 18 Oct 2022 17:45:52 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:45:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: don't report read ready on a FIFO never,
 opened for writing
Message-ID: <Y07KMM0XyO6ua9/Q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7163de6a-758b-5268-8ed1-eaa34fea7d94@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7163de6a-758b-5268-8ed1-eaa34fea7d94@cornell.edu>
X-Provags-ID: V03:K1:0CeWbNLA1j0NQdiQ9GBa+9NQxYSnJWjY2s4KyCi5y5beyvSk0+w
 Tljl2M6lvoYLtfhYePGc39MUgfEitoXsJQQb7KQce+9WJTumT7WtUGRTgw7ZUrdgmG2IR+2
 ncq+2oIcCnWczcwj6pXljws+MJIbpjA+vX+KHecUu/IlkBYEkmNYkoCtDrvQcKKJEYv0bg+
 88F3FNNCOwkwF4vk+5/Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fh1/Kfqhh0Q=:FEPmvzubY2pHemSTyyFwUP
 zUpVzmuJXmXSRGqqQBmOxm7INIxd8kQ3VSpFRCCO3KRGwY6uvoJ6De9VnPhtOsVq91uYUoSt2
 EtMUCyprcHu3NHxqIJx715FaaEEnZa5abwxCMkyrQIzCp/341n/ICOtBBXs3qKNIUkBQR3BSm
 jKcP9MVw7gI6qMQeBU/q6B5htkRLhTknu4bQoBEO2IDUA5bcocHIbIm2ohOzC3rFHK5tBHgmk
 JSHknIBTkZUZtws8M9W5afbQHO4K6pB9x6EA3sqygPHQrmxnz+IHB5ln7k5A+x/XqfIecuRey
 2AdY4dd5EUSaOxsDNmUKkjRtk2nIvPPHNiHGs/ys+aiQOy5a2sYSso81coJ3E+hW0DG5+oZgi
 Wk/rKAWvQGhASe1hPyUzf7yPzFKVqMvgtTcF3d2d5K0UnthnIx/eKVlEImXhat481Xm5j+fJe
 t7rE2lB9CCDJmzo+MNRU4h2dmLDHu5izMnzNo7P/ujv787At5IKoTgrV3LArPDlfB4MCEtHJH
 O/joZ1YE3PqGuoGUMOuAUmg3qw9tD+wJDnC3aBiOrjaQxrMYJYNsFCyNjIR7L4oZLstvfLwQ/
 OiI35Xq6fvqXypYv8BuXrBLkPzPWT4JQC0EVQJLX7ub3D6hsqQsq/b6B8d+Yn2Ok1A0TV/zV1
 o0nWDNBMUkEVRWfv3I6rftcKrWlHbm7yeS4p7waHlYRlGXSOQND6fSwXbxu0uRLmFFxWkQCbW
 iO2ZCK9OBVddUhMc3wUJejiumfCNn4mmgzLQ6ZHGRKOCpDHrfUd7bJW46hoBF8znjCpXUTPe2
 FkceQfQ0wHyRuC2vf84ga21SJ9ixw==
X-Spam-Status: No, score=-95.4 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sep 23 11:31, Ken Brown wrote:
> Patch attached.  I'm also attaching a test case, that behaves the same on
> Cygwin as on Linux.

Interesting case, but thinking about the scenario, it seems logical to
do it this way.

> @@ -1043,6 +1043,8 @@ writer_shmem:
>    set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
>    nwriters_lock ();
>    inc_nwriters ();
> +  if (!writer_opened () )
> +    set_writer_opened ();

My personal preference would be to skip the writer_opened() check
and just call set_writer_opened(), but that's just me.  If you like
it better that way, just push.


Thanks,
Corinna
