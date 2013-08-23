sub process_vhosts{
    # Deal with vhosts and url rewrites
    if (req.request == "PURGE") {
        # Purge
        if (req.url ~ "^/Plone/"){
            set req.http.host = "10.30.32.98";
            set req.url = "/VirtualHostBase/http/" + req.http.host + ":80/Plone/VirtualHostRoot" + req.url;
        }
    } elseif (req.http.host ~ "^(www.)?10.30.32.98(:[0-9]+)?$") {
        # Site 01
        set req.http.host = "10.30.32.98";
        set req.url = "/VirtualHostBase/http/" + req.http.host + ":80/Plone/VirtualHostRoot" + req.url;
    }
    else {
        error 404 "Unknown virtual host";
    }
}
