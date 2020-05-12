Return-Path: <yselkowi@redhat.com>
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by sourceware.org (Postfix) with ESMTP id 2A3D53938C2D
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 21:23:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2A3D53938C2D
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-zoBUY5JJOKeIwZRDZLHd_g-1; Tue, 12 May 2020 17:23:28 -0400
X-MC-Unique: zoBUY5JJOKeIwZRDZLHd_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17F761005510
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 21:23:28 +0000 (UTC)
Received: from ovpn-113-5.rdu2.redhat.com (ovpn-113-5.rdu2.redhat.com
 [10.10.113.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23547D8C3
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 21:23:27 +0000 (UTC)
Message-ID: <3749ce9f7c2eaeee1f600c4e8bede070f332bb69.camel@redhat.com>
Subject: Re: [PATCH] cygwin: doc: Add keywords for ACE order issues
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Date: Tue, 12 May 2020 17:23:26 -0400
In-Reply-To: <20200512224910.0000040e@gmail.com>
References: <20200512224910.0000040e@gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 12 May 2020 21:23:34 -0000

On Tue, 2020-05-12 at 22:49 +0200, David Macek via Cygwin-patches
wrote:
> Windows Explorer shows a warning with Cygwin-created DACLs, but putting
> the text of the warning into Google doesn't lead to the relevant Cygwin
> docs.  Let's copy the warning text into the docs in the hopes of helping
> confused users.
> 
> Latest inquiry: <https://cygwin.com/pipermail/cygwin/2020-May/244814.html>
> 
> Signed-off-by: David Macek <david.macek.0@gmail.com>
> ---
>  winsup/doc/ntsec.xml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index 08a33bdc6c..b94cdd9a97 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -2163,7 +2163,10 @@ preferred order.</para>
>  the Windows Explorer insists to rearrange the order of the ACEs to
>  canonical order before you can read them. Thank God, the sort order
>  remains unchanged if one presses the Cancel button.  But don't even
> -<emphasis role='bold'>think</emphasis> of pressing OK...</para>
> +<emphasis role='bold'>think</emphasis> of pressing OK...  For the sake
> +of people searching for this explanation, let's note that the Explorer
> +warning says "The permissions on ... are incorrectly orderer, which may
> +cause some entries to be ineffective."</para>
>  
>  <para>Canonical ACLs are unable to reflect each possible combination
>  of POSIX permissions. Example:</para>

The wording seems awkward.  Why not quote the text of the warning
directly earlier in the paragraph, e.g.:

<para>Unfortunately, the security tab in the file properties dialog of
the Windows Explorer will pop up a warning stating: "The permissions on
... are incorrectly ordered, which may cause some entries to be
ineffective."  Pressing the Cancel button will leave the order
unchanged, but pressing OK will cause Windows to canonicalize the order
of the ACEs, thereby invalidating POSIX compatibility.</para>

-- 
Yaakov Selkowitz
Senior Software Engineer - Platform Enablement
Red Hat, Inc.


