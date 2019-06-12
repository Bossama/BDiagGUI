linux-oe-g++ {
    message( embedded target-deployment )

    deployment.files = content/favorites.xml
    deployment.path = $$(datadir)/phytec-qtdemo
    target.path = $$(datadir)/phytec-qtdemo

    INSTALLS += target \
                deployment

    export(INSTALLS)
}
