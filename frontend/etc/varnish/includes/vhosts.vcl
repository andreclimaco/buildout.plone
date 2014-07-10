sub process_vhosts{
    # Deal with vhosts and url rewrites
    if (req.http.host ~ "^(www.)?meusite.com.br(:[0-9]+)?$") {
        # Site 01
        set req.http.host = "www.meusite.com.br";
        set req.url = "/VirtualHostBase/http/" + req.http.host + ":80/meusite/VirtualHostRoot" + req.url;
    } elseif (req.http.host ~ "^(www.)?meunovosite.com.br(:[0-9]+)?$") {
        # Site 02
        set req.http.host = "meunovosite";
        set req.url = "/VirtualHostBase/http/" + req.http.host + ":80/meunovosite/VirtualHostRoot" + req.url;
    }  
    else {
        error 404 "Unknown virtual host";
    }
}
